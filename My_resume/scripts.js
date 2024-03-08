document.addEventListener('DOMContentLoaded', function() {
    // Adding professional summary content if not already added
    const professionalSummaryElement = document.getElementById('summary');
    // Check if the professional summary already contains the expected content to prevent duplication
    const summaryContent = 'Innovative and insightful DevOps Engineer with over six years of experience in automating workflows, optimizing cloud solutions, and enhancing software development processes. Known for collaborative abilities, leadership skills, and a commitment to continual learning and adaptation in the ever-evolving field of technology.';
    if (professionalSummaryElement && !professionalSummaryElement.innerHTML.includes(summaryContent)) {
        professionalSummaryElement.innerHTML += `<p>${summaryContent}</p>`;
    }

    // Your existing code for dynamically adding employment history, making sections clickable, etc., goes here
    // Ensure no similar duplication issue occurs for other dynamic content

    // Example: Dynamically adding employment history (ensure no duplication if re-running this script)
    const employmentSection = document.getElementById('employment');
    // Assuming 'employment' section does not repeat the appending logic here...
    
    // Code to make sections clickable and to dynamically add social media links, if needed
});

    

document.addEventListener('DOMContentLoaded', function() {
    // Check if employment history has already been added to prevent duplication
    const employmentSection = document.getElementById('employment');
    if (!employmentSection.querySelector('.timeline-entry')) { // Only add if no entries exist
        const employmentHistory = [
            {
                role: 'DevOps Engineer - Dominion Systems, Maryland, USA',
                duration: 'August 2018 – Present',
                responsibilities: [
                    'Instrumental in architecting and executing automated CI/CD pipelines, resulting in a 40% reduction in deployment times and significant increase in deployment frequency.',
                    // More responsibilities...
                ]
            },
            {
                role: 'AWS Cloud Engineer - Dominion Systems, Maryland, USA',
                duration: 'June 2017 – July 2018',
                responsibilities: [
                    'Actively participated in multiple DevOps operations, leveraging AWS offerings to improve operational efficiency and infrastructure robustness.',
                    // More responsibilities...
                ]
            }
        ];

        employmentHistory.forEach(job => {
            const jobElement = document.createElement('div');
            jobElement.classList.add('timeline-entry');
            let responsibilitiesList = job.responsibilities.map(resp => `<li>${resp}</li>`).join('');
            jobElement.innerHTML = `
                <h3>${job.role}</h3>
                <p>${job.duration}</p>
                <ul>${responsibilitiesList}</ul>
            `;
            employmentSection.appendChild(jobElement);
        });
    }
    
    // Implement toggling for the details if needed, ensuring not to duplicate event listeners
    // Note: Ensure this part is compatible with your HTML structure. Adjust as necessary.
});

document.addEventListener('DOMContentLoaded', function() {
    // Previously included code for adding professional summary and employment history...
    // This part remains unchanged from your provided script.
    
    // Adding interaction to dynamically created elements
    const toggleDetails = function() {
        // This function toggles the visibility of the next sibling element
        // which in this case is assumed to be the <ul> containing job responsibilities
        if (this.nextElementSibling) {
            this.nextElementSibling.classList.toggle('hidden');
        }
    };

    // Attach event listeners to job titles for toggling visibility of details
    document.querySelectorAll('#employment .timeline-entry h3').forEach(jobTitle => {
        jobTitle.addEventListener('click', toggleDetails);
    });

    // If adding new content dynamically after the initial page load,
    // ensure to attach event listeners to those new elements as well.
});

