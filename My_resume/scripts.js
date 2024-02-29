document.addEventListener('DOMContentLoaded', function() {
    // Top Section: Headshot and Social Media Links
    const topSection = document.getElementById('top-section');

    // Create headshot image element
    const headshot = document.createElement('img');
    headshot.src = 'C:\Users\Achille T\Documents\GitHub\Resume_for_Static_Website\My_resume\headshot.jpg'; // Update with the path to your headshot image
    headshot.alt = 'Ali Achille Traore';
    headshot.classList.add('resume-headshot');

    // Append headshot to the top section
    const headshotContainer = document.createElement('div');
    headshotContainer.classList.add('headshot-container');
    headshotContainer.appendChild(headshot);
    topSection.appendChild(headshotContainer);

    // Social media icons
    const socialMediaLinks = {
        linkedin: 'linkedin.com/in/ali-achille-traore',
        github: 'https://github.com/traliach'
        // Add more social media profiles as needed
    };

    // Create and append social media icons
    Object.entries(socialMediaLinks).forEach(([platform, url]) => {
        const icon = document.createElement('a');
        icon.href = url;
        icon.target = '_blank'; // Open link in a new tab
        icon.rel = 'noopener noreferrer'; // Security measure for opening links in a new tab
        icon.innerHTML = `<img src="path_to_${platform}_icon.png" alt="${platform} icon" class="${platform}-icon" style="width: 30px; height: 30px;">`; // Update path to your icons
        topSection.appendChild(icon);
    });

document.addEventListener('DOMContentLoaded', function() {
    // Data for employment history
    const timelineData = [
        {
            date: 'August 2018 – Present',
            title: 'DevOps Engineer – Remote',
            company: 'Dominion Systems, Maryland, USA',
            responsibilities: [
                'Instrumental in architecting and executing automated CI/CD pipelines, resulting in a 40% reduction in deployment times and significant increase in deployment frequency.',
                'Championed the migration of legacy applications from monolithic to microservices architecture, enhancing system scalability and operational efficiency by 30%.',
                'Spearheaded robust application monitoring initiatives using NewRelic, Prometheus, Grafana, and EFK/ELK stacks, leading to a 25% reduction in incident response times.',
                'Effectively managed and configured web servers like Tomcat, Nginx, and Apache, optimizing web service delivery and performance.',
                'Focused on security enhancements across multiple platforms, including Linux, Docker, Kubernetes, Jenkins, reducing system vulnerabilities and security incidents.',
                'Expertise in orchestrating containers using Docker Swarm and Kubernetes, leading to improved resource utilization and deployment flexibility.',
                'Maintained high-availability Kubernetes clusters, achieving 99.9% uptime and ensuring seamless scalability and resilience.',
                'Automated infrastructure provisioning and configuration with Terraform and Ansible, streamlining processes and minimizing manual errors.',
                'Demonstrated mastery in AWS cloud services, optimizing infrastructure design and deployment, resulting in cost-effective cloud resource utilization.',
                'Implemented and managed various AWS components, ensuring a robust and resilient cloud infrastructure.',
                'Built complex automated CI/CD pipelines using interconnected tools.',
                'Kept up-to-date with new technologies by attending trainings, seminars, and conferences.'
            ]
        },
        {
            date: 'June 2017 – July 2018',
            title: 'AWS Cloud Engineer – Remote',
            company: 'Dominion Systems, Maryland, USA',
            responsibilities: [
                'Actively participated in multiple DevOps operations, leveraging AWS offerings such as CloudFormation, CodeCommit, CodeBuild, CodePipeline, CloudWatch, and API Gateway to improve operational efficiency and infrastructure robustness.',
                'Configured, installed, resizing, and deployed elastic computing resources in the AWS cloud, leading to a 20% improvement in resource utilization efficiency.',
                'Administered both RDS and non-relational databases, including Oracle, PostgreSQL, DynamoDB, Redshift, and Aurora, enhancing database performance and reliability.',
                'Developed and configured hybrid cloud networks and transit gateways, ensuring seamless integration and optimized data flow between various environments.',
                'Diligently maintained and upgraded the cloud infrastructure to enhance its availability, performance, operational stability, and security.',
                'Monitored, identified, and addressed infrastructure and application performance issues, as well as scaling challenges.',
                'Executed production change requests related to networking and managing the cloud infrastructure to ensure consistent operational stability and security.'
            ]
        }
    ];

    // Data for professional summary, skills, education, certifications, projects, and volunteer experience
    const professionalSummary = 'Innovative and insightful DevOps Engineer with over six years of experience in automating workflows, optimizing cloud solutions, and enhancing software development processes. Known for collaborative abilities, leadership skills, and a commitment to continual learning and adaptation in the ever-evolving field of technology.';
    
    const skills = [
        'CI/CD: Jenkins, Maven, SonarQube, Nexus, AWS CodePipeline',
        'Containerization & Orchestration: Docker, Kubernetes, OpenShift, Podman',
        'IaC: Terraform, AWS CloudFormation',
        'Networking: VPC, Subnets, Route Tables, Security Groups',
        'Cloud Technologies: AWS, Azure, GCP',
        'Monitoring: Prometheus, Grafana',
        'Operating Systems: Linux administration, Bash scripting',
        'Version Control: Git & GitHub',
        'Agile Methodology',
        'Programming Paradigms: Object-Oriented Programming',
        'Development: API Development, Mobile Development',
        'Cloud Computing, Machine Learning'
    ];

    const education = [
        'Bachelor\'s degree in Computer Science - Arizona State University',
        'Bachelor’s degree in Banking & Finance - ESCI'
    ];

    const certifications = [
        'AWS Certified DevOps Engineer – Professional',
        'AWS Certified Cloud Practitioner',
        'Google IT Support Specialization'
    ];

    const projects = [
        {
            title: 'Customer Self Service (CSS) Application for Zurich Farmers',
            duration: 'August 2020 - June 2022',
            role: 'DevOps Engineer',
            details: [
                'Developed and maintained the CSS application, managing over 15 million insurance policies.',
                'Automated deployment processes using Jenkins and Bash scripts.',
                'Managed branching and merging with GIT and SVN.',
                'Implemented Jenkins for CI builds and automated notifications.',
                'Conducted pre-QA testing, reducing post-deployment issues by 15%.',
                'Configured environment script files and managed deployments across stages (DEV, QA, UAT, STAGE, PROD), resulting in a 20% improvement in system uptime.',
                'Significantly enhanced customer satisfaction and operational efficiency by maintaining a high-performing system that managed a large volume of insurance policies.'
            ]
        }
    ];

    const volunteerExperience = [
        'International Emergency and Development Aid - IEDA Relief: Participated in disaster and humanitarian relief efforts, demonstrating a strong commitment to aiding those in crisis.'
    ];

    // Reference to containers
    const employmentTimeline = document.getElementById('employment-timeline');
    const professionalSummaryElement = document.getElementById('professional-summary');
    const skillsList = document.getElementById('skills-list');
    const educationList = document.getElementById('education-list');
    const certificationsList = document.getElementById('certifications-list');
    const projectsList = document.getElementById('projects-list');
    const volunteerExperienceList = document.getElementById('volunteer-experience-list');

    // Function to create and append timeline entries
    function createTimelineEntry(item, container) {
        let entry = document.createElement('div');
        entry.classList.add('timeline-entry');

        let date = document.createElement('div');
        date.textContent = item.date;
        date.classList.add('timeline-date');
        entry.appendChild(date);

        let title = document.createElement('h3');
        title.textContent = item.title;
        entry.appendChild(title);

        let company = document.createElement('p');
        company.textContent = item.company;
        entry.appendChild(company);

        let responsibilities = document.createElement('ul');
        item.responsibilities.forEach(function(resp) {
            let li = document.createElement('li');
            li.textContent = resp;
            responsibilities.appendChild(li);
        });
        entry.appendChild(responsibilities);

        container.appendChild(entry);
    }

    // Function to append professional summary
    professionalSummaryElement.textContent = professionalSummary;

    // Function to append skills
    skills.forEach(skill => {
        const skillItem = document.createElement('li');
        skillItem.textContent = skill;
        skillsList.appendChild(skillItem);
    });

    // Function to append education
    education.forEach(edu => {
        const eduItem = document.createElement('li');
        eduItem.textContent = edu;
        educationList.appendChild(eduItem);
    });

    // Function to append certifications
    certifications.forEach(cert => {
        const certItem = document.createElement('li');
        certItem.textContent = cert;
        certificationsList.appendChild(certItem);
    });

    // Function to append projects
    projects.forEach(project => {
        const projectItem = document.createElement('div');
        const projectTitle = document.createElement('h3');
        projectTitle.textContent = project.title;
        projectItem.appendChild(projectTitle);

        const projectDetails = document.createElement('ul');
        project.details.forEach(detail => {
            const detailItem = document.createElement('li');
            detailItem.textContent = detail;
            projectDetails.appendChild(detailItem);
        });
        projectItem.appendChild(projectDetails);

        projectsList.appendChild(projectItem);
    });

    // Function to append volunteer experience
    volunteerExperience.forEach(exp => {
        const expItem = document.createElement('li');
        expItem.textContent = exp;
        volunteerExperienceList.appendChild(expItem);
    });

    // Append employment history entries
    timelineData.forEach(item => {
        createTimelineEntry(item, employmentTimeline);
    });
});
document.addEventListener('DOMContentLoaded', function() {
    // All previous JavaScript code for defining data and appending to the DOM goes here
    // ...

    // Function to create a generic clickable and toggleable item
    function makeSectionClickable(containerId, highlightClass) {
        const container = document.getElementById(containerId);
        if (!container) return; // Exit if container not found

        container.addEventListener('click', function() {
            const isActive = container.classList.contains(highlightClass);
            container.classList.toggle(highlightClass, !isActive);

            // Toggle visibility of child details if needed
            const details = container.querySelectorAll('.details');
            details.forEach(detail => {
                detail.style.display = isActive ? 'none' : 'block';
            });
        });
    }

    // Making each section clickable and toggleable
    makeSectionClickable('professional-summary', 'highlight');
    makeSectionClickable('skills-list', 'highlight');
    makeSectionClickable('education-list', 'highlight');
    makeSectionClickable('certifications-list', 'highlight');
    makeSectionClickable('projects-list', 'highlight');
    makeSectionClickable('volunteer-experience-list', 'highlight');
    
    // Making individual entries within 'employment-timeline' and 'projects-list' clickable
    document.querySelectorAll('#employment-timeline .timeline-entry, #projects-list > div').forEach(item => {
        item.classList.add('clickable');
        item.addEventListener('click', function() {
            this.classList.toggle('highlight');
            const details = this.querySelector('.details');
            if (details) details.style.display = details.style.display === 'block' ? 'none' : 'block';
        });
    });
});