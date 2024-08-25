---@meta

---@class TAttachment
---@field onEquip? fun(PEntity: CBaseEntity, PAttachment: CItem)
---@field onUnequip? fun(PEntity: CBaseEntity, PAttachment: CItem)
---@field onManeuverGain? fun(PEntity: CBaseEntity, PAttachment: CItem, maneuvers: integer)
---@field onManeuverLose? fun(PEntity: CBaseEntity, PAttachment: CItem, maneuvers: integer)
---@field onUpdate? fun(PEntity: CBaseEntity, PAttachment: CItem, maneuvers: integer)
