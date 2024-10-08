---@meta

---@class CommandProperties : table
---@field permission integer
---@field parameters string

---@class TCommand
---@field cmdprops? CommandProperties
---@field onTrigger? fun(player: CBaseEntity, ...: any)
