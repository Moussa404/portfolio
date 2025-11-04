<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <title>@yield('title', 'Moussa Jaafar | Full Stack Developer')</title>

  <!-- theme meta -->
  <meta name="theme-color" content="#0b1220">

  <!-- CSS -->
  <link rel="stylesheet" href="{{ asset('css/style.css') }}">
  <style>
  * { cursor: none !important; }
</style>

</head>
<body class="dark-bg">
  <header class="site-header">
    <div class="container header-inner">
      <div class="brand">
        <a href="/" class="logo">Moussa<span class="accent">.</span>J</a>
        <div class="tag">Full Stack Web Developer</div>
      </div>

      <nav class="nav">
        <a href="/" class="nav-link">Home</a>
        <a href="/about" class="nav-link">About</a>
        <a href="/projects" class="nav-link">Projects</a>
        <a href="/contact" class="nav-link">Contact</a>
      </nav>

      <div class="socials">
        <a href="https://github.com/Moussa404" target="_blank" rel="noopener" class="icon">GitHub</a>
        <a href="https://www.linkedin.com/in/moussa-j-784081254" target="_blank" rel="noopener" class="icon">LinkedIn</a>
        <a href="mailto:moussajaafar8@gmail.com" class="icon">Email</a>
      </div>
    </div>
  </header>

  <main class="container main-content">
    @yield('content')
  </main>

  <footer class="site-footer">
    <div class="container">
      <div>© {{ date('Y') }} Moussa Jaafar — Full Stack Web Developer</div>
      <div><a href="/files/Moussa_Jaafar_CV.pdf" class="cv-btn" download>Download CV</a></div>
    </div>
  </footer>

  <script>window.App = { githubUser: "Moussa404" };</script>
  <script src="{{ asset('js/script.js') }}"></script>
</body>
</html>
