%STATIC_REPOSITORY_CHECK Lightweight checks for repository completeness.

repoRoot = fileparts(fileparts(fileparts(mfilename('fullpath'))));

requiredFiles = { ...
    'README.md', ...
    'scripts/matlab/mmc_scaling_analysis.m', ...
    'scripts/matlab/run_all_scaling_figures.m', ...
    'docs/methodology.md', ...
    'docs/scaling-laws.md' ...
};

for k = 1:numel(requiredFiles)
    f = fullfile(repoRoot, requiredFiles{k});
    assert(isfile(f), 'Missing required file: %s', requiredFiles{k});
end

tempFiles = dir(fullfile(repoRoot, '**', '~$*'));
assert(isempty(tempFiles), 'Temporary Office lock files should not be committed.');

fprintf('Static repository check passed.\n');
