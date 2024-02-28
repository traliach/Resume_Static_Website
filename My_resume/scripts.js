document.addEventListener('DOMContentLoaded', function() {
    // Data for employment history
    const timelineData = [
        {
            date: 'August 2018 – Present',
            title: 'DevOps Engineer – Remote',
            description: 'At Dominion Systems, Maryland, USA, orchestrated automated CI/CD pipelines, migrated legacy applications to microservices, and managed web servers like Tomcat, Nginx, and Apache. Focused on security enhancements and container orchestration using Docker and Kubernetes.'
        },
        {
            date: 'June 2017 – July 2018',
            title: 'AWS Cloud Engineer – Remote',
            description: 'At Dominion Systems, Maryland, USA, participated in multiple DevOps operations using AWS offerings like CloudFormation and CodePipeline. Configured and deployed elastic computing resources and administered RDS and non-relational databases.'
        },
        // Additional entries can be added here
    ];

    // Data for projects
    const projectData = [
        {
            title: 'Onboarding Project – Farmers.com/css - Zurich Farmers',
            duration: 'August 2020 - June 2022',
            role: 'DevOps Engineer',
            technologies: 'GIT, SVN, Maven, Jenkins, AIX, Core Java, JSP, Servlets, Struts',
            overview: 'Developed and maintained the Customer Self Service (CSS) application, a vital platform for managing insurance services for Zurich Farmers. The project focused on streamlining insurance policy management for over 15 million policies.',
            achievements: [
                'Automated deployment processes using Jenkins, reducing deployment time by 25%. Developed a Bash script for deploying WAR files to WebLogic servers.',
                'Managed branching and merging with GIT and SVN, improving code consistency.',
                'Implemented Jenkins for CI builds and automated notifications.',
                'Conducted pre-QA testing, reducing post-deployment issues by 15%.',
                'Configured environment script files and managed deployments across stages (DEV, QA, UAT, STAGE, PROD), resulting in a 20% improvement in system uptime.'
            ],
            impact: 'Significantly enhanced customer satisfaction and operational efficiency.'
        }
        // Additional projects can be added here
    ];

    const employmentTimeline = document.getElementById('employment-timeline');
    const projectTimeline = document.getElementById('project-timeline');

    // Function to create and append timeline entries
    function createTimelineEntry(item, container, isProject = false) {
        let entry = document.createElement('div');
        entry.classList.add('timeline-entry');

        let dot = document.createElement('div');
        dot.classList.add('timeline-dot');

        let dateOrDuration = document.createElement('div');
        dateOrDuration.textContent = isProject ? item.duration : item.date;
        dateOrDuration.classList.add('timeline-date');

        let content = document.createElement('div');
        content.classList.add('timeline-content');

        let title = document.createElement('h3');
        title.textContent = item.title;

        let description = document.createElement('p');
        description.textContent = isProject ? item.overview : item.description;
        description.classList.add('hidden'); // Utilize a CSS class to toggle visibility

        content.appendChild(title);
        content.appendChild(description);

        entry.appendChild(dot);
        entry.appendChild(dateOrDuration);
        entry.appendChild(content);

        container.appendChild(entry);

        // Toggle the display of the description on click
        entry.addEventListener('click', function() {
            description.classList.toggle('hidden');
        });
    }

    // Append employment history entries
    timelineData.forEach((item) => {
        createTimelineEntry(item, employmentTimeline);
    });

    // Append project entries
    projectData.forEach((item) => {
        createTimelineEntry(item, projectTimeline, true);
    });
});
