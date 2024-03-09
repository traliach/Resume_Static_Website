document.addEventListener('DOMContentLoaded', function() {
    // Adding professional summary content if not already added
    const professionalSummaryElement = document.getElementById('summary');
    const summaryContent = 'Innovative and insightful DevOps Engineer with over six years of experience in automating workflows, optimizing cloud solutions, and enhancing software development processes. Known for collaborative abilities, leadership skills, and a commitment to continual learning and adaptation in the ever-evolving field of technology.';
    if (professionalSummaryElement && !professionalSummaryElement.innerHTML.includes(summaryContent)) {
        professionalSummaryElement.innerHTML += `<p>${summaryContent}</p>`;
    }

    // Making sections clickable
    const clickableTitles = document.querySelectorAll('.timeline-entry h3');
    clickableTitles.forEach(title => {
        title.addEventListener('click', function() {
            this.nextElementSibling.classList.toggle('hidden');
        });
    });

    // Dynamically adding employment history if it hasn't already been added
    const employmentSection = document.getElementById('employment');
    if (!employmentSection.querySelector('.timeline-entry')) {
        const employmentHistory = [
            {
                role: 'DevOps Engineer - Dominion Systems, Maryland, USA',
                duration: 'August 2018 – Present',
                responsibilities: [
                    'Instrumental in architecting and executing automated CI/CD pipelines, resulting in a 40% reduction in deployment times and significant increase in deployment frequency.',
                    // More responsibilities...
                ]
            },
            // More jobs...
        ];

        employmentHistory.forEach(job => {
            const jobElement = document.createElement('div');
            jobElement.classList.add('timeline-entry');
            let responsibilitiesList = job.responsibilities.map(resp => `<li>${resp}</li>`).join('');
            jobElement.innerHTML = `<h3>${job.role}</h3><p>${job.duration}</p><ul>${responsibilitiesList}</ul>`;
            employmentSection.appendChild(jobElement);
        });
    }
});
