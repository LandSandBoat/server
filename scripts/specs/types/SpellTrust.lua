---@meta

---@class TSpellTrust
---@field onMagicCastingCheck? fun(PChar: CBaseEntity, PTarget: CBaseEntity, PSpell: CSpell): integer?
---@field onSpellCast? fun(PCaster: CBaseEntity, PTarget: CBaseEntity, PSpell: CSpell): integer?
---@field onMobSpawn? fun(PMob: CBaseEntity): nil
---@field onMobDespawn? fun(PMob: CBaseEntity): nil
---@field onMobDeath? fun(PMob: CBaseEntity, PKiller: CBaseEntity?): nil
