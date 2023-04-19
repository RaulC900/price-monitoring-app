package raul.project.priceupdater.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import raul.project.priceupdater.models.User;
import raul.project.priceupdater.repositories.UsersRepository;

import java.util.List;
import java.util.Optional;

@Service
public class UsersService {

    private final UsersRepository usersRepository;

    @Autowired
    public UsersService(UsersRepository usersRepository) {
        this.usersRepository = usersRepository;
    }

    public User getUserByEmail(String email) {
        Optional<User> u = usersRepository.findByEmail(email);
        if(!u.isEmpty()) {
            return u.get();
        }

        return null;
    }
}
