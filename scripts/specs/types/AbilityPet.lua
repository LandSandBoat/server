---@meta

---@class TAbilityPet
---@field onAbilityCheck? fun(PChar: CBaseEntity, PTarget: CBaseEntity, PAbility: CAbility): (integer?, integer?)
---@field onPetAbility? fun(PTarget: CBaseEntity, PMob: CBaseEntity, PMobSkill: CMobSkill|CPetSkill, PMaster: CBaseEntity, action: CAction): integer?
