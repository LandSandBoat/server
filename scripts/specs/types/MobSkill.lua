---@meta

---@class MobSkillSetup : Action
---@field flags? xi.skillFlag[]
---@field prepareTime number

---@class TMobSkill
---@field onMobSkillSetup? fun(): MobSkillSetup
---@field onMobSkillCheck? fun(PTarget: CBaseEntity, PMob: CBaseEntity, PMobSkill: CMobSkill): integer?
---@field onMobWeaponSkill? fun(PTarget: CBaseEntity, PMob: CBaseEntity, PMobSkill: CMobSkill, action: CAction): integer?
---@field onMobSkillFinalize? fun(PMob: CBaseEntity, PMobSkill: CMobSkill): nil
