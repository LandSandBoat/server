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
local column =
{
    TELEPORT_ID       = 1,
    TELEPORT_KEY_ITEM = 2,
    TELEPORT_DURATION = 3,
    TELEPORT_CAMPAIGN = 4,
}

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

-- Main function for Teleport / Warp / etc. Spells.
xi.spells.enhancing.useTeleportSpell = function(caster, target, spell)
    spell:setMsg(xi.msg.basic.NONE)

    if target:getObjType() == xi.objType.PC then
        return 0
    end

    if target:hasStatusEffect(xi.effect.MOUNTED) then
        return 0
    end

    local spellId = spell:getID()
    local keyItem = pTable[spellId][column.TELEPORT_KEY_ITEM]
    if keyItem > 0 and not target:hasKeyItem(keyItem) then
        return 0
    end

    local campaign = pTable[spellId][column.TELEPORT_CAMPAIGN]
    if campaign and target:getCampaignAllegiance() == 0 then
        return 0
    end

    target:addStatusEffect(xi.effect.TELEPORT, { power = pTable[spellId][column.TELEPORT_ID], duration = pTable[spellId][column.TELEPORT_DURATION], origin = caster, icon = 0 })
    spell:setMsg(xi.msg.basic.MAGIC_TELEPORT)

    return xi.effect.TELEPORT
end
