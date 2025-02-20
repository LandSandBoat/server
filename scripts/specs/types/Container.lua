-- Interaction Container definitions
---@meta

---@class ZoneSection
---@field onZoneIn? fun(player: CBaseEntity, prevZone: xi.zone): integer|table<integer>?
---@field onZoneOut? onZoneHandler
---@field afterZoneIn? onZoneHandler
---@field onEventUpdate? onEventHandler
---@field onEventFinish? onEventHandler
---@field onTriggerAreaEnter? onTriggerAreaHandler
---@field onTriggerAreaLeave? onTriggerAreaHandler
---@field [string]? EntitySection|TAction|fun(player: CBaseEntity, npc: CBaseEntity): TAction?

---@alias onZoneHandler fun(player: CBaseEntity): TAction?

---@class onTriggerAreaHandler
---@field [integer] fun(player: CBaseEntity, triggerArea: ITriggerArea, optInstance: CInstance?): TAction?

---@class EntitySection
---@field onTrade? TAction|fun(player: CBaseEntity, npc: CBaseEntity, trade: CTradeContainer): TAction?
---@field onTrigger? TAction|fun(player: CBaseEntity, npc: CBaseEntity): TAction?
---@field onMobDeath? fun(mob: CBaseEntity, player: CBaseEntity, optParams: { isKiller: boolean, noKiller: boolean, isWeaponSkillKill: boolean, weaponskillUsed: xi.weaponskill, weaponskillDamage: integer })

---@class onEventHandler
---@field [integer] fun(player: CBaseEntity, csid: integer, option: integer, npc: CBaseEntity)

-- Quest and Mission sections vary slightly based on their check function (below):
---@class TQuestSection
---@field check fun(player: CBaseEntity, status: xi.questStatus, vars: { [string]: integer }): boolean
---@field [xi.zone] ZoneSection

---@class TMissionSection
---@field check fun(player: CBaseEntity, currentMission: integer, missionStatus: integer, vars: { [string]: integer }): boolean
---@field [xi.zone] ZoneSection
