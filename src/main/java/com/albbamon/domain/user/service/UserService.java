package com.albbamon.domain.user.service;

import com.albbamon.domain.user.dto.request.CreateUserRequestDto;
import com.albbamon.domain.user.entity.User;
import com.albbamon.domain.user.repository.UserRepository;
import com.albbamon.global.common.util.EncoderUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Objects;

@RequiredArgsConstructor
@Service
public class UserService {
    private final UserRepository userRepository;
    private final EncoderUtil encoderUtil;

    public void createUser(CreateUserRequestDto requestDto) {
        checkAlreadyExistingUser(requestDto.email());
        String encodedPassword = encoderUtil.encrypt(requestDto.password());
        User user = User.createUser(requestDto, encodedPassword);
        userRepository.save(user);
    }

    private void checkAlreadyExistingUser(String email) {
        User user = userRepository.findByEmail(email);
        if(!Objects.isNull(user)) {
            // Duplicate User Exception
        }
    }
}
