---@meta

---@class AbilityRequirements
---@field job xi.job
---@field level integer
---@field addType? xi.addType -- Prerequisite flags (merit, arts, pet type, etc.)

---@class RecastDefinition
---@field time integer -- Recast time in seconds
---@field id? integer -- Shared recast ID (if different from ability ID)
---@field meritId? xi.merit -- Merit mod ID for recast reduction

---@class AbilitySetup : Action
---@field requirements AbilityRequirements
---@field recast RecastDefinition
---@field actionType? xi.action.category -- Default ABILITY_FINISH

---@class TAbility
---@field onAbilitySetup? fun(): AbilitySetup
---@field onAbilityCheck? fun(PChar: CBaseEntity, PTarget: CBaseEntity, PAbility: CAbility): (integer?, integer?)
---@field onUseAbility? fun(PUser: CBaseEntity, PTarget: CBaseEntity, PAbility: CAbility, action: CAction): integer?
