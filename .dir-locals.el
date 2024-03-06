
((nil . ((eval . (progn
                   ;; Set the OpenAI key
                   (setq org-ai-openai-api-token
                         (or
                          (getenv "OPENAI_KEY") "OPENAI_KEY not set"))
                   ;; (setq org-ai-default-chat-model "gpt-4-0613")
                   (setq org-ai-default-chat-model "gpt-4-1106-preview")
                   ;; PlantUML
                   (setq plantuml-default-exec-mode 'jar)))
               ))
      ))
