-----------------------------------
-- Area: Mamool Ja Training Grounds (Imperial Agent Rescue)
--  MOB: Mamool Ja Warder (WHM)
-----------------------------------
mixins = { require('scripts/mixins/weapon_break') }

local warder = require('scripts/zones/Mamool_Ja_Training_Grounds/globals/warder')
-----------------------------------
---@type TMobEntity
local entity = {}

local whmRoamBuffs =
{
    xi.magic.spell.PROTECT_IV,
    xi.magic.spell.SHELL_IV,
    xi.magic.spell.BLINK,
    xi.magic.spell.STONESKIN,
    xi.magic.spell.AQUAVEIL,
    xi.magic.spell.HASTE,
    xi.magic.spell.BARBLIZZARA,
}

entity.onMobSpawn = function(mob)
    warder.onMobSpawn(mob)

    mob:addMod(xi.mod.MAIN_DMG_RATING, 35)
    mob:setMod(xi.mod.STR, 10)
    mob:setMod(xi.mod.ATT, 270)
end

entity.onMobRoam = function(mob)
    if mob:getCurrentAction() ~= xi.action.category.ROAMING then
        return
    end

    local cooldown = mob:getLocalVar('magicBuffCooldown')
    if cooldown == 0 then
        mob:castSpell(whmRoamBuffs[math.randomInt(1, #whmRoamBuffs)], mob)
        mob:setLocalVar('magicBuffCooldown', math.randomInt(3, 5))
    else
        mob:setLocalVar('magicBuffCooldown', cooldown - 1)
    end
end

entity.onMobWeaponSkill = warder.onMobWeaponSkill

return entity
