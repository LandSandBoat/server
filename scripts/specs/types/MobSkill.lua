---@meta

---@class TMobSkill
---@field onMobSkillCheck? fun(PTarget: CBaseEntity, PMob: CBaseEntity, PMobSkill: CMobSkill): integer?
---@field onMobWeaponSkill? fun(PMob: CBaseEntity, PTarget: CBaseEntity, PMobSkill: CMobSkill, action: CAction): integer?
---@field onMobSkillFinalize? fun(PMob: CBaseEntity, PMobSkill: CMobSkill): nil
