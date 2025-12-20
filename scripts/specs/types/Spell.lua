---@meta

---@class SpellRequirements
---@field special? xi.magic.spellReq -- Flag indicating special requirements for the spell to be usable
---@field jobs table<xi.job, integer> -- Job to level mapping
---@field cost? integer -- MP Cost

---@class SpellSetup : Action
---@field skill xi.skill -- Magic skill associated with the spell
---@field group xi.magic.spellGroup
---@field family? xi.magic.spellFamily
---@field element xi.element -- Spell element
---@field requirements SpellRequirements -- Set of requirements for the spell to be usable
---@field castTime number -- Cast time, in seconds
---@field recast integer -- Recast time, in seconds

---@class TSpell
---@field onSpellSetup? fun(): SpellSetup
---@field onMagicCastingCheck? fun(PChar: CBaseEntity, PTarget: CBaseEntity, PSpell: CSpell): integer?
---@field onSpellCast? fun(PCaster: CBaseEntity, PTarget: CBaseEntity, PSpell: CSpell): integer?
