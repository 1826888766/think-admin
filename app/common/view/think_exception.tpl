<?php
/** @var array $traces */
if (!function_exists('parse_padding')) {
    function parse_padding($source)
    {
        $length  = strlen(strval(count($source['source']) + $source['first']));
        return 40 + ($length - 1) * 8;
    }
}

if (!function_exists('parse_class')) {
    function parse_class($name)
    {
        $names = explode('\\', $name);
        return '<abbr title="'.$name.'">'.end($names).'</abbr>';
    }
}

if (!function_exists('parse_file')) {
    function parse_file($file, $line)
    {
        return '<a class="toggle" title="'."{$file} line {$line}".'">'.basename($file)." line {$line}".'</a>';
    }
}

if (!function_exists('parse_args')) {
    function parse_args($args)
    {
        $result = [];
        foreach ($args as $key => $item) {
            switch (true) {
                case is_object($item):
                    $value = sprintf('<em>object</em>(%s)', parse_class(get_class($item)));
                    break;
                case is_array($item):
                    if (count($item) > 3) {
                        $value = sprintf('[%s, ...]', parse_args(array_slice($item, 0, 3)));
                    } else {
                        $value = sprintf('[%s]', parse_args($item));
                    }
                    break;
                case is_string($item):
                    if (strlen($item) > 20) {
                        $value = sprintf(
                            '\'<a class="toggle" title="%s">%s...</a>\'',
                            htmlentities($item),
                            htmlentities(substr($item, 0, 20))
                        );
                    } else {
                        $value = sprintf("'%s'", htmlentities($item));
                    }
                    break;
                case is_int($item):
                case is_float($item):
                    $value = $item;
                    break;
                case is_null($item):
                    $value = '<em>null</em>';
                    break;
                case is_bool($item):
                    $value = '<em>' . ($item ? 'true' : 'false') . '</em>';
                    break;
                case is_resource($item):
                    $value = '<em>resource</em>';
                    break;
                default:
                    $value = htmlentities(str_replace("\n", '', var_export(strval($item), true)));
                    break;
            }

            $result[] = is_int($key) ? $value : "'{$key}' => {$value}";
        }

        return implode(', ', $result);
    }
}
if (!function_exists('echo_value')) {
    function echo_value($val)
    {
        if (is_array($val) || is_object($val)) {
            echo htmlentities(json_encode($val, JSON_PRETTY_PRINT));
        } elseif (is_bool($val)) {
            echo $val ? 'true' : 'false';
        } elseif (is_scalar($val)) {
            echo htmlentities($val);
        } else {
            echo 'Resource';
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/static/lib/layui/css/layui.css">
    <script src="/static/lib/layui/layui.js"></script>
    <style>
        .exception-title {
            text-align: center;
            height: 80vh;
            display: flex;
            justify-content: center;
            align-items: center;
            flex-direction: column;
        }

        .exception-title i {
            font-size: 200px;
        }

        .exception-title .layui-text {
            margin-top: 15px;
        }

        /* Base */
        body {
            color: #333;
            font: 16px Verdana, "Helvetica Neue", helvetica, Arial, 'Microsoft YaHei', sans-serif;
            margin: 0;
            padding: 0;
        }

        .line-error {
            background: #f8cbcb;
        }

        .echo table {
            width: 100%;
        }

        .echo pre {
            padding: 16px;
            overflow: auto;
            font-size: 85%;
            line-height: 1.45;
            background-color: #f7f7f7;
            border: 0;
            border-radius: 3px;
            font-family: Consolas, "Liberation Mono", Menlo, Courier, monospace;
        }

        .echo pre>pre {
            padding: 0;
            margin: 0;
        }

        /* Exception Info */
        .exception {
            margin-top: 20px;
        }

        .exception .message {
            padding: 12px;
            border: 1px solid #ddd;
            border-bottom: 0 none;
            line-height: 18px;
            font-size: 16px;
            border-top-left-radius: 4px;
            border-top-right-radius: 4px;
            font-family: Consolas, "Liberation Mono", Courier, Verdana, "微软雅黑", serif;
        }

        .exception .code {
            float: left;
            text-align: center;
            color: #fff;
            margin-right: 12px;
            padding: 16px;
            border-radius: 4px;
            background: #999;
        }

        .exception .source-code {
            padding: 6px;
            border: 1px solid #ddd;

            background: #f9f9f9;
            overflow-x: auto;

        }

        .exception .source-code pre {
            margin: 0;
        }

        .exception .source-code pre ol {
            margin: 0;
            color: #4288ce;
            display: inline-block;
            min-width: 100%;
            box-sizing: border-box;
            font-size: 14px;
            font-family: "Century Gothic", Consolas, "Liberation Mono", Courier, Verdana, serif;
            padding-left: <?php echo (isset($source) && !empty($source)) ? parse_padding($source): 40;?>px;
        }

        .exception .source-code pre li {
            border-left: 1px solid #ddd;
            height: 18px;
            line-height: 18px;
        }

        .exception .source-code pre code {
            color: #333;
            height: 100%;
            display: inline-block;
            border-left: 1px solid #fff;
            font-size: 14px;
            font-family: Consolas, "Liberation Mono", Courier, Verdana, "微软雅黑", serif;
        }

        .exception .trace {
            padding: 6px;
            border: 1px solid #ddd;
            border-top: 0 none;
            line-height: 16px;
            font-size: 14px;
            font-family: Consolas, "Liberation Mono", Courier, Verdana, "微软雅黑", serif;
        }

        .exception .trace h2:hover {
            text-decoration: underline;
            cursor: pointer;
        }

        .exception .trace ol {
            margin: 12px;
        }

        .exception .trace ol li {
            padding: 2px 4px;
        }

        .exception div:last-child {
            border-bottom-left-radius: 4px;
            border-bottom-right-radius: 4px;
        }

        /* Exception Variables */
        .exception-var table {
            width: 100%;
            margin: 12px 0;
            box-sizing: border-box;
            table-layout: fixed;
            word-wrap: break-word;
        }

        .exception-var table caption {
            text-align: left;
            font-size: 16px;
            font-weight: bold;
            padding: 6px 0;
        }

        .exception-var table caption small {
            font-weight: 300;
            display: inline-block;
            margin-left: 10px;
            color: #ccc;
        }

        .exception-var table tbody {
            font-size: 13px;
            font-family: Consolas, "Liberation Mono", Courier, "微软雅黑", serif;
        }

        .exception-var table td {
            padding: 0 6px;
            vertical-align: top;
            word-break: break-all;
        }

        .exception-var table td:first-child {
            width: 28%;
            font-weight: bold;
            white-space: nowrap;
        }

        .exception-var table td pre {
            margin: 0;
        }

        /* Copyright Info */
        .copyright {
            margin-top: 24px;
            padding: 12px 0;
            border-top: 1px solid #eee;
        }

        /* SPAN elements with the classes below are added by prettyprint. */
        pre.prettyprint .pln {
            color: #000
        }

        /* plain text */
        pre.prettyprint .str {
            color: #080
        }

        /* string content */
        pre.prettyprint .kwd {
            color: #008
        }

        /* a keyword */
        pre.prettyprint .com {
            color: #800
        }

        /* a comment */
        pre.prettyprint .typ {
            color: #606
        }

        /* a type name */
        pre.prettyprint .lit {
            color: #066
        }

        /* a literal value */
        /* punctuation, lisp open bracket, lisp close bracket */
        pre.prettyprint .pun,
        pre.prettyprint .opn,
        pre.prettyprint .clo {
            color: #660
        }

        pre.prettyprint .tag {
            color: #008
        }

        /* a markup tag name */
        pre.prettyprint .atn {
            color: #606
        }

        /* a markup attribute name */
        pre.prettyprint .atv {
            color: #080
        }

        /* a markup attribute value */
        pre.prettyprint .dec,
        pre.prettyprint .var {
            color: #606
        }

        /* a declaration; a variable name */
        pre.prettyprint .fun {
            color: red
        }

        /* a function name */
        /* a function name */
    </style>
</head>

<body>
    <div class="exception-title">
        <i class="layui-icon" face="">&#xe69c;</i>
        <div class="layui-text" style="font-size: 20px;">
            <div>
                <h2>
                    <?php 
          if (\think\facade\App::isDebug()) { 
            foreach ($traces as $index => $trace) { 
              echo nl2br(htmlentities($trace['message'])); 
            } 
           } else { 
            echo htmlentities($message);
           } ?>
                </h2>
            </div>
        </div>
    </div>

    <div class="exception">
        <?php if (!empty($trace['source'])) { ?>
        <div class="source-code">
            <pre
                class="prettyprint lang-php"><ol start="<?php echo $trace['source']['first']; ?>"><?php foreach ((array) $trace['source']['source'] as $key => $value) { ?><li class="line-<?php echo "{$index}-"; echo $key + $trace['source']['first']; echo $trace['line'] === $key + $trace['source']['first'] ? ' line-error' : ''; ?>"><code><?php echo htmlentities($value); ?></code></li><?php } ?></ol></pre>
        </div>
        <?php }?>
        <div class="trace">
            <h2 data-expand="<?php echo 0 === $index ? '1' : '0'; ?>">Call Stack</h2>
            <ol>
                <li>
                    <?php echo sprintf('in %s', parse_file($trace['file'], $trace['line'])); ?>
                </li>
                <?php foreach ((array) $trace['trace'] as $value) { ?>
                <li>
                    <?php
                // Show Function
                if ($value['function']) {
                    echo sprintf(
                        'at %s%s%s(%s)',
                        isset($value['class']) ? parse_class($value['class']) : '',
                        isset($value['type'])  ? $value['type'] : '',
                        $value['function'],
                        isset($value['args'])?parse_args($value['args']):''
                    );
                }

                // Show line
                if (isset($value['file']) && isset($value['line'])) {
                    echo sprintf(' in %s', parse_file($value['file'], $value['line']));
                }
                ?>
                </li>
                <?php } ?>
            </ol>
        </div>
    </div>
</body>

</html>