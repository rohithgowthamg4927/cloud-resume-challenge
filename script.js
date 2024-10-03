document.querySelectorAll('.sidebar nav ul li a').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
        e.preventDefault();

        const targetId = this.getAttribute('href').substring(1);
        const targetElement = document.getElementById(targetId);
        
        if (window.innerWidth < 768) {
            smoothScrollTo(targetElement, 10); 
        } else {
            targetElement.scrollIntoView({ behavior: 'smooth' });
        }
    });
});

function smoothScrollTo(target, duration) {
    let targetPosition = target.getBoundingClientRect().top + window.scrollY;
    let startPosition = window.scrollY;
    let distance = targetPosition - startPosition;
    let startTime = null;

    function animation(currentTime) {
        if (startTime === null) startTime = currentTime;
        let timeElapsed = currentTime - startTime;
        let run = ease(timeElapsed, startPosition, distance, duration);
        window.scrollTo(0, run);
        if (timeElapsed < duration) requestAnimationFrame(animation);
    }

    function ease(t, b, c, d) {
        t /= d / 2;
        if (t < 1) return c / 2 * t * t + b;
        t--;
        return -c / 2 * (t * (t - 2) - 1) + b;
    }

    requestAnimationFrame(animation);
}


window.addEventListener('resize', function () {
    document.querySelectorAll('section').forEach(section => {
        section.style.height = `${window.innerHeight}px`;
    });
});

window.dispatchEvent(new Event('resize'));

document.addEventListener('DOMContentLoaded', () => {
    const hamburger = document.getElementById('hamburger');
    const sidebar = document.getElementById('sidebar');

    function adjustSidebarHeight() {
        if (window.innerWidth <= 768) {
            const headerHeight = document.querySelector('.sidebar-header').offsetHeight;
            const socialHeight = document.querySelector('.socials').offsetHeight;

            const availableHeight = window.innerHeight - headerHeight - socialHeight;
            sidebar.style.height = `${availableHeight}px`;
        } else {
            sidebar.style.height = '100vh';
        }
    }

    hamburger.addEventListener('click', () => {
        sidebar.classList.toggle('active');
        adjustSidebarHeight();
    });

    window.addEventListener('resize', adjustSidebarHeight);
    adjustSidebarHeight();
});

const count = document.querySelector(".page-views");
async function updateViewerCount() {
    let resp = await fetch("https://vdozaflmfqf7t5bs5ez2lthoqm0qkivc.lambda-url.ap-south-1.on.aws/");
    let views = await resp.json();
    count.innerHTML = `Total Views👀: ${views}`;
}
updateViewerCount();