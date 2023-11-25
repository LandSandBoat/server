-----------------------------------
-- Teleport Spell Utilities
-----------------------------------
require('scripts/globals/teleports')
-----------------------------------
xi = xi or {}
xi.spells = xi.spells or {}
xi.spells.enhancing = xi.spells.enhancing or {}
-----------------------------------
-- Table variables.
local pTable =
{
-- Structure:       [spellId] = { Teleport, Key_Item, duration, campaign },
    [xi.magic.spell.ESCAPE        ] = { xi.teleport.id.ESCAPE,  0,                              4, false },
    [xi.magic.spell.RECALL_JUGNER ] = { xi.teleport.id.JUGNER,  xi.ki.JUGNER_GATE_CRYSTAL,      4, false },
    [xi.magic.spell.RECALL_MERIPH ] = { xi.teleport.id.MERIPH,  xi.ki.MERIPHATAUD_GATE_CRYSTAL, 4, false },
    [xi.magic.spell.RECALL_PASHH  ] = { xi.teleport.id.PASHH,   xi.ki.PASHHOW_GATE_CRYSTAL,     4, false },
    [xi.magic.spell.RETRACE       ] = { xi.teleport.id.RETRACE, 0,                              3, true  },
    [xi.magic.spell.TELEPORT_ALTEP] = { xi.teleport.id.ALTEP,   xi.ki.ALTEPA_GATE_CRYSTAL,      4, false },
    [xi.magic.spell.TELEPORT_DEM  ] = { xi.teleport.id.DEM,     xi.ki.DEM_GATE_CRYSTAL,         4, false },
    [xi.magic.spell.TELEPORT_HOLLA] = { xi.teleport.id.HOLLA,   xi.ki.HOLLA_GATE_CRYSTAL,       4, false },
    [xi.magic.spell.TELEPORT_MEA  ] = { xi.teleport.id.MEA,     xi.ki.MEA_GATE_CRYSTAL,         4, false },
    [xi.magic.spell.TELEPORT_VAHZL] = { xi.teleport.id.VAHZL,   xi.ki.VAHZL_GATE_CRYSTAL,       4, false },
    [xi.magic.spell.TELEPORT_YHOAT] = { xi.teleport.id.YHOAT,   xi.ki.YHOATOR_GATE_CRYSTAL,     4, false },
    [xi.magic.spell.WARP          ] = { xi.teleport.id.WARP,    0,                              3, false },
    [xi.magic.spell.WARP_II       ] = { xi.teleport.id.WARP,    0,                              3, false },
}

-- Check for "Retrace" Spell.
xi.spells.enhancing.checkTeleportSpell = function(caster, target, spell)
    if target:getCampaignAllegiance() > 0 then
        return 0
    else
        return 48
    end
end

-- Main function for Teleport / Warp / etc. Spells.
xi.spells.enhancing.useTeleportSpell = function(caster, target, spell)
    local spellId    = spell:getID()
    local teleportId = pTable[spellId][1]
    local keyItem    = pTable[spellId][2]
    local duration   = pTable[spellId][3]
    local campaign   = pTable[spellId][4]

    if
        target:getObjType() == xi.objType.PC and
        (keyItem == 0 or (keyItem > 0 and target:hasKeyItem(keyItem))) and
        (not campaign or (campaign and target:getCampaignAllegiance() > 0))
    then
        target:addStatusEffectEx(xi.effect.TELEPORT, 0, teleportId, 0, duration)
        spell:setMsg(xi.msg.basic.MAGIC_TELEPORT)
    else
        spell:setMsg(xi.msg.basic.NONE)
    end

    return 0
end
