
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent
# https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account

ssh-keygen -t ed25519 -C "peter.vandivier@gmail.com"
Get-Service -Name ssh-agent | Set-Service -StartupType Manual
Start-Service ssh-agent
Get-Content ~/.ssh/id_ed25519.pub -raw | clip
