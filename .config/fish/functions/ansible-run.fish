function ansible-run
  cd $HOME/Projects/ansible-playbooks
  switch $argv[1]
    case update_all
      command ansible-playbook -kK -v playbooks/archlinux_update.yml --tags update_packages $argv[2]
    case backup_ssh
      command ansible-playbook -kK -v -l (hostname) playbooks/backup.yml --tags backup $argv[2]
  end
  cd -
end
