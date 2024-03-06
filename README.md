# fluidX3D-Tooling

Tooling built around FluidX3D, started as part of our FluidX3D fork, split for simplicity's sake.

This code was written using Ubuntu on WSL 2.0 on a Windows 11 machine and tested there as well as on BeoShock, Wichita State University's HPC node and a personal computing node.

Because of the limits of the HPC environment and the other things that HPC entails, some scripts had to be so heavily rewritten that it made sense to instead develop two versions of them.  As I get better at bash programming and as this project matures, these may merge back together again with the limitations of respective systems being avoided using configuration files and the like.

There's a lot that needs to be done here to make this as reusable as possible, and I can't think of everything that needs to be done as I only have access to an infinitesimally small amount of compute in comparison to what's available out there.  If you stumble on this and need help, submit a pull request!

*why did you build this?*

FluidX3D is *quite* the powerful program, but as it's the work of a single person, it's quite barebones in some areas - for instance, there's no post-processing done on the still frames of the videos it produces.

Luckily, Linux systems are quite extendable and it's really not that hard to build your own stuff.

*eventual goals for the future?*

Ideally, I'd like to integrate a configuration file with FluidX3D that allows me to do things like specify rendered image resolution or GPU config or VRAM usage so that it's a little easier to tweak the settings on a per-machine basis instead of keeping track of what got changed job-to-job.

*Is this stuff cross-platform?*

If you're willing to count using WSL as supporting Windows, sure.  This isn't done out of malice - We simply have next to no need for windows-specific tooling in our environment.

## Major Scripts

### ``postProcess.sh``, ``postprocess_local.sh`` & ``postprocess_remote.sh``

At their core, these take the still frames rendered by ``FluidX3D`` and use ``FFmpeg`` to convert the images to videos, running once in every subfolder in ``/bin/export``.

Eventually this will also handle archiving the images from old runs and clearing out temporary directories, might also get smart enough to be able to farm out each job to its own machine.  (yay burst computing!)

### ``scheduler.sh``

One-stop-shop script that gets submitted via ``sbatch`` to the HPC cluster.

### ``batchjob.sh``

This is the part that builds and runs FluidX3D and contains the necessary slurm commands to get a GPU instance.
