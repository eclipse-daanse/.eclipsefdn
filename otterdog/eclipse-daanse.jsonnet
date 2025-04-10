local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';


local daanseBranchProtectionRule(branchName) = orgs.newBranchProtectionRule(branchName) {
  required_approving_review_count: 0,
  requires_linear_history: true,
  requires_strict_status_checks: true,
};

local newDaanseRepo(repoName, default_branch = 'main') = orgs.newRepo(repoName) {
  allow_squash_merge: false,
  allow_update_branch: false,
  default_branch: default_branch,
  delete_branch_on_merge: false,
  dependabot_security_updates_enabled: true,
  has_wiki: false,
  homepage: "https://www.daanse.org",
  web_commit_signoff_required: false,
  branch_protection_rules: [
    daanseBranchProtectionRule($.default_branch) {},
  ],
};

orgs.newOrg('technology.daanse', 'eclipse-daanse') {

  settings+: {
    description: "The Eclipse Daanse Project - Data Analysis Services",
    name: "Eclipse Daanse",
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },

  secrets+: [        
    orgs.newOrgSecret('DOCKER_USERNAME') {
      value: "pass:bots/technology.daanse/docker.com/username",
    },
    orgs.newOrgSecret('DOCKER_TOKEN') {
      value: "pass:bots/technology.daanse/docker.com/api-token",
    },
    orgs.newOrgSecret('GITLAB_API_TOKEN') {
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
      value: "pass:bots/technology.daanse/oss.sonatype.org/gh-token-password",
    },
    orgs.newOrgSecret('ORG_OSSRH_USERNAME') {
      value: "pass:bots/technology.daanse/oss.sonatype.org/gh-token-username",
    },
    orgs.newOrgSecret('NPMJS_TOKEN') {
      value: "pass:bots/technology.daanse/npmjs.com/token",
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

    newDaanseRepo('.github') {
      description: "github organisation repository, defaults for all other daanse Repositories",
    },
    newDaanseRepo('legacy.dashboard.client') {
      code_scanning_default_setup_enabled: true,
      code_scanning_default_languages: [
        'javascript-typescript'
      ],
      gh_pages_build_type: "workflow"
    },
    newDaanseRepo('legacy.xmla') {
      description: "Repository that hold old/legacy sources. To be split/migrated into new Repository.",
     },
    newDaanseRepo('org.eclipse.daanse.board.app') {
      description: "Repository for the analysis board application",
      code_scanning_default_setup_enabled: true,
      code_scanning_default_languages: ['javascript', 'typescript']
      secrets+: [
        orgs.newRepoSecret('ARGOS_TOKEN') {
          value: "pass:bots/technology.daanse/argos-ci.com/token",
        },
      ],
    },
    newDaanseRepo('org.eclipse.daanse.board.model') {
      description: "Repository for the models of the board components",
    },
    newDaanseRepo('org.eclipse.daanse.board.server') {
      description: "Repository for the optional server components of the board",
    },
    newDaanseRepo('org.eclipse.daanse.emf.model') {
      description: "Repository for the emf models used in daanse",
    },
    newDaanseRepo('org.eclipse.daanse.emf.dbmapping') {
      description: "Repository for the emf dbmapping related modules",
    },
    newDaanseRepo('org.eclipse.daanse.index') {
      description: "Repository for the index related modules",
    },
    newDaanseRepo('org.eclipse.daanse.io.fs.watcher') {
      description: "Repository for the io watcher",
    },
    newDaanseRepo('org.eclipse.daanse.jakarta.servlet') {
      description: "Repository for the jakarta servlet related modules",
    },
    newDaanseRepo('org.eclipse.daanse.jakarta.xml.ws') {
      description: "Repository for the jakarta xml ws modules",
    },
    newDaanseRepo('org.eclipse.daanse.jdbc.datasource') {
      aliases: ['org.eclipse.daanse.jdbc.datasource.metatype.h2'],
      description: "Repository for the datasource support",
    },
    newDaanseRepo('org.eclipse.daanse.jdbc.db') {
      description: "Repository for the jdbc related database utils",
    },
    newDaanseRepo('org.eclipse.daanse.mdx') {
      description: "Repository for the mdx - multi dimensional expressions",
    },
    newDaanseRepo('org.eclipse.daanse.operation') {
      description: "Repository for the operation",
    },
    newDaanseRepo('org.eclipse.daanse.pom') {
      description: "Repository for the maven poms",
    },
    newDaanseRepo('org.eclipse.daanse.rdb') {
      description: "Repository for the relational database related modules",
    },
    newDaanseRepo('org.eclipse.daanse.report') {
      description: "Repository for the report related modules",
    },
    newDaanseRepo('org.eclipse.daanse.rolap.mapping') {
      description: "Repository for the rolap mapping",
    },
    newDaanseRepo('org.eclipse.daanse.sql') {
      description: "Repository for the sql related modules",
    },
    newDaanseRepo('org.eclipse.daanse.webconsole.branding') {
      description: "Repository for the webconsole branding",
    },
    newDaanseRepo('org.eclipse.daanse.xmla') {
      description: "Repository for the xmla modules",
    },
    newDaanseRepo('Tutorials') {
      description: "Repository for the Tutorials",
    },
  ],
}
