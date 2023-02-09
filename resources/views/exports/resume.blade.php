<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width,initial-scale=1">
        <meta name="description" content="">
    <link href='https://fonts.googleapis.com/css?family=Lato:400,300,700' rel='stylesheet' type='text/css'>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        html {
            height: 100%;  
            width: 100%;  
        }

        body {
            width: 100%;  
            min-height: 100%;  
            background: #eee;
            font-family: 'Lato', sans-serif;
            font-weight: 400;
            color: #222;
            font-size: 14px;
            line-height: 26px;
            padding-bottom: 50px;
        }

    </style>
    </head>
<body>
    <div style=" width:500px; margin-left:50px;">
        <div style="margin-top:30px;">
            <h1 style="color: #222; text-transform: uppercase; font-size: 40px; margin-bottom:0px;">{{ $user->first_name }} <span style="font-weight:300;">{{ $user->last_name}}</span></h1>
            <div style="margin-top:10px; ">
                <div><span style="color:#555;">Email:</span> {{ $user->email }} &nbsp;<span style="color:#999;">|</span> &nbsp; <span style="color:#555;">Phone:</span> {{ $user->phone }}</div>
            </div>
            <div style="margin-top:30px; ">
                <div style="color:#333;">
                    {{ $user->content }}
                </div>
            </div>



            <div style="margin-top:30px; ">
                <h3 style="margin-bottom:20px; color:#000;">Core Competencies</h3>

                @foreach($job_subcategory_skills as $key => $job_subcategory_skill)
                @if(count($job_subcategory_skill) > 0)
                <div style="margin-bottom:10px;">
                   <h4 style="color:#333;">{{ $key }}</h4>
                   <ul>
                        @foreach($job_subcategory_skill as $job_type)
                            <li style="padding-bottom:8px; color:#333; padding-left:10px;"><span>{{ $job_type }}</span></li>
                        @endforeach
                    </ul>
                </div>
                @endif
                @endforeach
            </div>
        </div>
    </div>
</body>
</html>

