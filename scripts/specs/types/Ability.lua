---@meta

---@class TAbility
---@field onAbilityCheck? fun(PChar: CBaseEntity, PTarget: CBaseEntity, PAbility: CAbility): (integer?, integer?)
---@field onUseAbility? fun(PUser: CBaseEntity, PTarget: CBaseEntity, PAbility: CAbility, action: CAction): integer?
