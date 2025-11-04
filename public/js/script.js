// public/js/script.js

// Small DOM helper
const $ = (sel, root = document) => root.querySelector(sel);
const $$ = (sel, root = document) => Array.from(root.querySelectorAll(sel));

document.addEventListener('DOMContentLoaded', () => {
  // Contact form (client-side demo)
  const form = document.getElementById('contactForm');
  if (form) {
    form.addEventListener('submit', (e) => {
      e.preventDefault();
      alert('Thanks — message received (demo). I will contact you soon.');
      form.reset();
    });
  }

  // GitHub repos fetch and display
  const githubContainer = document.getElementById('github-repos');
  if (!githubContainer) return;

  const username = window.App && window.App.githubUser ? window.App.githubUser : 'Moussa404';
  const endpoint = `https://api.github.com/users/${encodeURIComponent(username)}/repos?per_page=50&sort=updated`;

  // helper to build a repo card
  const repoCard = (repo) => {
    const el = document.createElement('article');
    el.className = 'project-card';
    el.innerHTML = `
      <h3>${repo.name}</h3>
      <p>${repo.description ? repo.description : 'No description.'}</p>
      <div class="meta">
        ${repo.language ? `<span>${repo.language}</span>` : ''}
        <span>⭐ ${repo.stargazers_count}</span>
        <span><a href="${repo.html_url}" target="_blank" rel="noopener">View on GitHub</a></span>
      </div>
    `;
    return el;
  };

  githubContainer.innerHTML = '<div class="loading">Loading public repositories…</div>';

  fetch(endpoint)
    .then(res => {
      if (!res.ok) throw new Error('GitHub API error: ' + res.status);
      return res.json();
    })
    .then(repos => {
      githubContainer.innerHTML = '';
      // filter: show repos that are not forks first (or show all)
      repos.sort((a,b) => new Date(b.updated_at) - new Date(a.updated_at));
      if (repos.length === 0) {
        githubContainer.innerHTML = '<div class="card">No public repositories found.</div>';
        return;
      }
      repos.forEach(r => {
        githubContainer.appendChild(repoCard(r));
      });
    })
    .catch(err => {
      console.error(err);
      githubContainer.innerHTML = `<div class="card">Could not load GitHub repositories. You can still view projects from the CV above. (${err.message})</div>`;
    });
});
// ... your existing JS code (GitHub repos, etc.) ...

// === CUSTOM VISUAL EFFECTS ===

// 1️⃣ Floating glowing circles background
document.addEventListener("DOMContentLoaded", () => {
  const canvas = document.createElement("canvas");
  canvas.id = "bgCanvas";
  document.body.prepend(canvas);
  const ctx = canvas.getContext("2d");

  let width, height, particles = [];
  const particleCount = 25;

  function resize() {
    width = canvas.width = window.innerWidth;
    height = canvas.height = window.innerHeight;
  }
  window.addEventListener("resize", resize);
  resize();

  for (let i = 0; i < particleCount; i++) {
    particles.push({
      x: Math.random() * width,
      y: Math.random() * height,
      r: Math.random() * 3 + 2,
      dx: (Math.random() - 0.5) * 0.8,
      dy: (Math.random() - 0.5) * 0.8,
    });
  }

  function draw() {
    ctx.clearRect(0, 0, width, height);
    ctx.fillStyle = "rgba(0,180,255,0.3)";
    particles.forEach(p => {
      ctx.beginPath();
      ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
      ctx.fill();
      p.x += p.dx;
      p.y += p.dy;

      if (p.x < 0 || p.x > width) p.dx *= -1;
      if (p.y < 0 || p.y > height) p.dy *= -1;
    });
    requestAnimationFrame(draw);
  }

  draw();
});

// 2️⃣ Fade-in scroll animation
const observer = new IntersectionObserver((entries) => {
  entries.forEach(entry => {
    if (entry.isIntersecting) {
      entry.target.classList.add('visible');
    }
  });
});
document.querySelectorAll('section, .card, .project-card').forEach(el => {
  el.classList.add('hidden');
  observer.observe(el);
});
// === Orbiting dual-ring tech cursor ===
const cursor = document.createElement('div');
cursor.className = 'dual-ring-cursor';
cursor.innerHTML = `
  <div class="ring outer"></div>
  <div class="ring inner"></div>
`;
document.body.appendChild(cursor);

let lastX = 0, lastY = 0, glowIntensity = 10;

document.addEventListener('mousemove', e => {
  const dx = e.clientX - lastX;
  const dy = e.clientY - lastY;
  const speed = Math.sqrt(dx * dx + dy * dy);

  glowIntensity = Math.min(30, 10 + speed / 2);
  document.querySelectorAll('.ring').forEach(r => {
    r.style.filter = `drop-shadow(0 0 ${glowIntensity}px rgb(0,180,255))`;
  });

  cursor.style.transform = `translate(${e.clientX}px, ${e.clientY}px)`;
  lastX = e.clientX;
  lastY = e.clientY;
});

// Hover color change
document.querySelectorAll('a, button').forEach(el => {
  el.addEventListener('mouseenter', () => {
    document.querySelectorAll('.ring').forEach(r => r.style.borderColor = '#ff004c');
  });
  el.addEventListener('mouseleave', () => {
    document.querySelectorAll('.ring').forEach(r => r.style.borderColor = 'rgb(0,180,255)');
  });
});


// Track mouse position
document.addEventListener('mousemove', e => {
  cursor.style.transform = `translate(${e.clientX}px, ${e.clientY}px)`;
});

// Change glow color on hover (yellow or red)
document.querySelectorAll('a, button').forEach(el => {
  el.addEventListener('mouseenter', () => {
    document.querySelectorAll('.ring').forEach(r => r.style.borderColor = '#ff004c'); // red
  });
  el.addEventListener('mouseleave', () => {
    document.querySelectorAll('.ring').forEach(r => r.style.borderColor = 'rgb(0,180,255)'); // blue
  });
});



// Change glow color when hovering clickable elements
document.querySelectorAll('a, button').forEach(el => {
  el.addEventListener('mouseenter', () => {
    glow.style.background = 'red'; // choose 'yellow' or 'red'
    glow.style.boxShadow = '0 0 25px red';
  });
  el.addEventListener('mouseleave', () => {
    glow.style.background = 'rgb(0,180,255)'; // original blue
    glow.style.boxShadow = '0 0 25px rgb(0,180,255)';
  });
});

// Make the glow cursor grow when hovering clickable elements
document.querySelectorAll('a, button').forEach(el => {
  el.addEventListener('mouseenter', () => {
    glow.style.transform += ' scale(1.8)';
    glow.style.opacity = '0.7';
  });
  el.addEventListener('mouseleave', () => {
    glow.style.transform = glow.style.transform.replace(' scale(1.8)', '');
    glow.style.opacity = '1';
  });
});

document.addEventListener("DOMContentLoaded", () => {
  const contactSection = document.querySelector(".contact-section");
  if (!contactSection) return;

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        contactSection.style.transition = "opacity 1.2s ease, transform 1.2s ease";
        contactSection.style.opacity = "1";
        contactSection.style.transform = "translateY(0)";
      }
    });
  }, { threshold: 0.2 });

  contactSection.style.opacity = "0";
  contactSection.style.transform = "translateY(30px)";
  observer.observe(contactSection);
});
