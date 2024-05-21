function ansible-run
  cd $HOME/Projects/ansible-playbooks
  switch $argv[1]
    case update_all
      ANSIBLE_STDOUT_CALLBACK=debug ansible-playbook -kK -v playbooks/archlinux_update.yml --tags update_packages $argv[2..-1]
    case backup_ssh
      ANSIBLE_STDOUT_CALLBACK=debug ansible-playbook -kK --ask-vault-pass -v -l (hostname) playbooks/backup.yml --tags backup $argv[2..-1]
  end
  cd -
end
