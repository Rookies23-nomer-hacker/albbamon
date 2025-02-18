package com.albbamon.domain.resume.service;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.albbamon.domain.post.entity.Post;
import com.albbamon.domain.post.repository.PostRepository;
import com.albbamon.domain.resume.entity.Resume;
import com.albbamon.domain.resume.repository.ResumeRepository;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class ResumeService {

    private final ResumeRepository resumeRepository;

    // 모든 게시물 조회
    public List<Resume> getAllResumes() {
        return resumeRepository.findAll();
    }

    // 게시물 ID로 조회
    public Resume getResumeById(Long resumeId) {
        Optional<Resume> resume = resumeRepository.findById(resumeId);
        return resume.orElse(null);
    }
}
