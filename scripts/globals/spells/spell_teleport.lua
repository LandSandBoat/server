-----------------------------------
-- Teleport Spell Utilities
-----------------------------------
require("scripts/globals/spells/parameters")
require("scripts/globals/spell_data")
require("scripts/globals/teleports")
require("scripts/globals/keyitems")
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.spell_teleport = xi.spells.spell_teleport or {}
-----------------------------------
-- Table variables.
local teleportTable = xi.spells.parameters.teleportSpell

-- Check for "Retrace" Spell.
xi.spells.spell_teleport.checkTeleportSpell = function(caster, target, spell)
    if target:getCampaignAllegiance() > 0 then
        return 0
    else
        return 48
    end
end

-- Main function for Teleport / Warp / etc... Spells.
xi.spells.spell_teleport.useTeleportSpell = function(caster, target, spell)
    local spellId    = spell:getID()
    local teleportId = teleportTable[spellId][1]
    local keyItem    = teleportTable[spellId][2]
    local paramFive  = teleportTable[spellId][3]
    local campaign   = teleportTable[spellId][4]

    if
        target:getObjType() == xi.objType.PC and
        (keyItem == 0 or (keyItem > 0 and target:hasKeyItem(keyItem))) and
        (not campaign or (campaign and target:getCampaignAllegiance() > 0))
    then
        target:addStatusEffectEx(xi.effect.TELEPORT, 0, teleportId, 0, paramFive)
        spell:setMsg(xi.msg.basic.MAGIC_TELEPORT)
    else
        spell:setMsg(xi.msg.basic.NONE)
    end

    return 0
end
