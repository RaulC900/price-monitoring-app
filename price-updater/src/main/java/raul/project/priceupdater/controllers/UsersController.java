package raul.project.priceupdater.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import raul.project.priceupdater.models.User;
import raul.project.priceupdater.services.UsersService;

@Controller
@RequestMapping(value="/users")
public class UsersController {

    private final UsersService usersService;

    @Autowired
    public UsersController(UsersService usersService) {
        this.usersService = usersService;
    }

    @GetMapping(value = "/{email}")
    private ResponseEntity<User> getUser(@PathVariable String email) {
        User u = usersService.getUserByEmail(email);
        if(u == null) {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }

        return new ResponseEntity<>(u, HttpStatus.OK);
    }

//    @PostMapping
//    private User getUser(@RequestBody User user) {
//
//    }
}
