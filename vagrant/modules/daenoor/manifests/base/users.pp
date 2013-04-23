# Class: base::users
# 
# Sample users and groups
#
class daenoor::base::users {
    
    # Groups
    @group { "admins":
        gid => '999',
        tag => "admins",
        ensure => present,
    }

    @group { "developers":
        gid => '998',
        tag => "developers",
        ensure => present,
    }

    # Root
    # password is 'puppet' (without quotes)
    @user { "root":
        ensure => present,
        password => '$6$$1z48.X3KuWbjAGh5yZ0g2cZkcPiEDZYSwzJQ0SUtdgHHgVd0EVhC1efDIr6uu.nuQSKZY12P9lVPE0bM2znUV1',
    }

    # Users

    @user::managed{ "developer":
        ensure => present,
        name_comment => "Developer",
        uid => "1998",
        managehome => true,
        groups => "developers",
        tag => "developers",
        manage_group => true,
    }
}