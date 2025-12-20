---@meta

---@class PetSkillSetup : Action
---@field mobSkillId? integer -- Related mob skill ID
---@field flags? xi.skillFlag[]
---@field actionType? xi.action.category -- Default PET_MOBABILITY_FINISH

---@class TAbilityPet
---@field onPetSkillSetup? fun(): PetSkillSetup
---@field onAbilityCheck? fun(PChar: CBaseEntity, PTarget: CBaseEntity, PAbility: CAbility): (integer?, integer?)
---@field onPetAbility? fun(PTarget: CBaseEntity, PMob: CBaseEntity, PMobSkill: CMobSkill|CPetSkill, PMaster: CBaseEntity, action: CAction): integer?
