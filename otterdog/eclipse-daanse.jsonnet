local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('eclipse-daanse') {
  settings+: {
    description: "The Eclipse Daanse Project - Data Analysis Services",
    name: "Eclipse Daanse",
    readers_can_create_discussions: true,
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  secrets+: [
    orgs.newOrgSecret('DASH_IPLAB_TOKEN') {
      value: "pass:bots/technology.daanse/gitlab.eclipse.org/api-token",
    },
    orgs.newOrgSecret('ORG_GPG_KEY_ID') {
      value: "pass:bots/technology.daanse/gpg/key_id",
    },
    orgs.newOrgSecret('ORG_GPG_PASSPHRASE') {
      value: "pass:bots/technology.daanse/gpg/passphrase",
    },
    orgs.newOrgSecret('ORG_GPG_PRIVATE_KEY') {
      value: "pass:bots/technology.daanse/gpg/secret-subkeys.asc",
    },
    orgs.newOrgSecret('ORG_OSSRH_PASSWORD') {
      value: "pass:bots/technology.daanse/oss.sonatype.org/password",
    },
    orgs.newOrgSecret('ORG_OSSRH_USERNAME') {
      value: "pass:bots/technology.daanse/oss.sonatype.org/username",
    },
  ],
  _repositories+:: [
    orgs.newRepo('eclipse-daanse.github.io') {
      allow_squash_merge: false,
      allow_update_branch: false,
      gh_pages_build_type: "legacy",
      gh_pages_source_branch: "main",
      gh_pages_source_path: "/",
      environments: [
        orgs.newEnvironment('github-pages') {
          branch_policies+: [
            "main"
          ],
          deployment_branch_policy: "selected",
        },
      ],
    },
    orgs.newRepo('org.eclipse.daanse.common') {
      allow_squash_merge: false,
      allow_update_branch: false,
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Repository for the common modules",
      has_wiki: false,
      secrets: [
        orgs.newRepoSecret('SONAR_TOKEN') {
          value: "pass:bots/technology.daanse/sonarcloud.io/token-eclipse-daanse-common",
        },
      ],
      variables: [
        orgs.newRepoVariable('SONAR_ORGANIZATION') {
          value: "eclipse-daanse",
        },
        orgs.newRepoVariable('SONAR_PROJECT_KEY') {
          value: "eclipse-daanse_org.eclipse.daanse.common",
        },
      ],
      branch_protection_rules: [
        orgs.newBranchProtectionRule('main') {
          required_approving_review_count: 0,
          requires_linear_history: true,
          requires_strict_status_checks: true,
        },
      ],
    },
  ],
}
