-- Supporting Class Definitions for Interaction Quests.  TQuest definition
-- is contained within scripts/globals/interaction/quest.lua

---@meta

-- Definitions for quest.sections{}
---@alias TQuestSectionList TQuestSection[]

---@class TQuestSection
---@field check fun(player: CBaseEntity, status: xi.questStatus, vars: { [string]: integer }): boolean
---@field [xi.zone] TQuestZoneSection

-- TODO: Below here, we can most likely be generic and reuse these definitions for Hidden Quests, Missions,
-- and perhaps Battlefields as well
---@class TQuestZoneSection
---@field onZoneIn? TQuestOnZoneIn
---@field onZoneOut? TQuestOnZoneFunction
---@field afterZoneIn? TQuestOnZoneFunction
---@field [string]? TQuestZoneEntity|QuestReturnType|fun(player: CBaseEntity, npc: CBaseEntity): QuestReturnType?
---@field onEventUpdate? TQuestEventSection
---@field onEventFinish? TQuestEventSection
---@field onTriggerAreaEnter? TQuestTriggerAreaSection
---@field onTriggerAreaLeave? TQuestTriggerAreaSection

---@class TQuestOnZoneIn
---@field [integer] fun(player: CBaseEntity, prevZone: xi.zone): integer?

---@class TQuestOnZoneFunction
---@field [integer] fun(player: CBaseEntity): QuestReturnType?

---@class TQuestTriggerAreaSection
---@field [integer] fun(player: CBaseEntity, triggerArea: CTriggerArea): QuestReturnType?

---@class TQuestZoneEntity
---@field onTrade? QuestReturnType|fun(player: CBaseEntity, npc: CBaseEntity, trade: CTradeContainer): QuestReturnType?
---@field onTrigger? QuestReturnType|fun(player: CBaseEntity, npc: CBaseEntity): QuestReturnType?
---@field onMobDeath? fun(mob: CBaseEntity, player: CBaseEntity, optParams: { isKiller: boolean, noKiller: boolean, isWeaponSkillKill: boolean, weaponskillUsed: xi.weaponskill, weaponskillDamage: integer })

---@class TQuestEventSection
---@field [integer] fun(player: CBaseEntity, csid: integer, option: integer, npc: CBaseEntity)

---@alias QuestReturnType TInteractionEvent|TInteractionKeyItem|TInteractionMessage|TInteractionSequence|TInteractionAction|TInteractionNoAction?
