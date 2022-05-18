{ lib
, fetchpatch
, kernel
# , date ? "2022-04-25"
# , commit ? "bdf6d7c1350497bc7b0be6027a51d9330645672d"
# , diffHash ? "09bcbklvfj9i9czjdpix2iz7fvjksmavaljx8l92ay1i9fapjmhc"
, date ? "2022-04-08"
, commit ? "6ddf061e68560a2bb263b126af7e894a6c1afb5f"
, diffHash ? "1nkrr1cxavw0rqxlyiz7pf9igvqay0d5kk7194v9ph3fcp9rz5kc"
, kernelPatches # must always be defined in bcachefs' all-packages.nix entry because it's also a top-level attribute supplied by callPackage
, argsOverride ? {}
, ...
} @ args:

# NOTE: bcachefs-tools should be updated simultaneously to preserve compatibility
(kernel.override ( args // {
  argsOverride = {
    version = "${kernel.version}-bcachefs-unstable-${date}";

    extraMeta = {
      branch = "master";
      maintainers = with lib.maintainers; [ davidak Madouura ];
    };
  } // argsOverride;

  kernelPatches = [ {
      name = "bcachefs-${commit}";

      patch = fetchpatch {
        name = "bcachefs-${commit}.diff";
        url = "https://evilpiepirate.org/git/bcachefs.git/rawdiff/?id=${commit}&id2=v${lib.versions.majorMinor kernel.version}";
        sha256 = diffHash;
      };

      extraConfig = "BCACHEFS_FS m";
    } ] ++ kernelPatches;
}))
