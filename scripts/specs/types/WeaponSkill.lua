---@meta

---@class WeaponSkillRequirements
---@field skill xi.skill -- Weapon type granting access to WS
---@field level? integer -- Skill level required to access the WS
---@field jobs? table<xi.job> -- List of jobs who can use the weaponskill
---@field mainOnly? boolean -- WS only available if you have any job in the jobs table as your main job

---@class WeaponSkillSetup : Action
---@field requirements WeaponSkillRequirements -- Requirements to be met to be granted access to the weaponskill
---@field element? xi.element -- Associated element of the WS

---@class TWeaponSkill
---@field onWeaponSkillSetup? fun(): WeaponSkillSetup
---@field onUseWeaponSkill? fun(player: CBaseEntity, target: CBaseEntity, wsID: integer, tp: integer, primary: boolean, action: CAction, taChar: CBaseEntity?): (integer?, integer?, boolean?, integer?)
