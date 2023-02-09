<!DOCTYPE html>
<html lang="en">
  <head>
    <meta name="csrf-token" content="{{ csrf_token() }}"  />
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@100;400;600;900&display=swap" rel="stylesheet">
    @include('layouts._head')
    @yield('stylesheets')
    
    <style>
        h1, h2, h3, h4, h5, h6 {
            font-family: Montserrat;
            font-weight: 400;
        }
        p { color:#777; font-size:14px; font-family: "Montserrat", "HelveticaNeue", "Helvetica Neue", Helvetica, Arial, sans-serif; }
    </style>
  </head>
  <body>
    <div id="app">
        <header> @include('layouts._nav') </header>
        <main>   @yield('content') </main>
        <footer> @include('layouts._footer') </footer>
    </div>

    @include('layouts._javascript')
    <script src="/app/js/vue.js"></script>
    
    @include('components.resume-form')
    @include('components.user-menu')
    @include('components.job-application')
    @include('components.require-auth')

    @yield('scripts','')

    <script>
        new Vue({ el: '#app' })  
    </script>

  </body>
</html>