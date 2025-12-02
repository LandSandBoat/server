---@meta

---@class TItemFood
---@field onItemCheck? fun(target: CBaseEntity, item: CItem?, param: integer?, caster: CBaseEntity?): integer
---@field onItemUse? fun(target: CBaseEntity, user: CBaseEntity?, item: CItem, action: CAction): integer?
---@field onEffectGain? fun(target: CBaseEntity, effect: CStatusEffect): nil
---@field onEffectLose? fun(target: CBaseEntity, effect: CStatusEffect): nil
