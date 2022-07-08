-- Animated Weapons Mixin for Era Dynamis Module
-- Used to perform text choices and determine when to warp.

require("scripts/globals/mixins")
require("scripts/zones/Dynamis-Xarcabard/IDs")
require("modules/era/lua_dynamis/globals/era_dynamis_spawning")

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

local ID = zones[xi.zone.DYNAMIS_XARCABARD]
local dialogChoice =
{
    ["DE_AKnu"] = ID.text.ANIMATED_KNUCKLES_DIALOG,
    ["DE_ADag"] = ID.text.ANIMATED_DAGGER_DIALOG,
    ["DE_ALon"] = ID.text.ANIMATED_LONGSWORD_DIALOG,
    ["DE_ACla"] = ID.text.ANIMATED_CLAYMORE_DIALOG,
    ["DE_ATab"] = ID.text.ANIMATED_TABAR_DIALOG,
    ["DE_AGre"] = ID.text.ANIMATED_GREATAXE_DIALOG,
    ["DE_ASpe"] = ID.text.ANIMATED_SPEAR_DIALOG,
    ["DE_AScy"] = ID.text.ANIMATED_SCYTHE_DIALOG,
    ["DE_AKun"] = ID.text.ANIMATED_KUNAI_DIALOG,
    ["DE_ATac"] = ID.text.ANIMATED_TACHI_DIALOG,
    ["DE_AHam"] = ID.text.ANIMATED_HAMMER_DIALOG,
    ["DE_ASta"] = ID.text.ANIMATED_STAFF_DIALOG,
    ["DE_Alon"] = ID.text.ANIMATED_LONGBOW_DIALOG,
    ["DE_AGun"] = ID.text.ANIMATED_GUN_DIALOG,
    ["DE_AHor"] = ID.text.ANIMATED_HORN_DIALOG,
    ["DE_AShi"] = ID.text.ANIMATED_SHIELD_DIALOG,
}

g_mixins.families.animated_weapons = function(animatedMob)

    animatedMob:addListener("SPAWN", "AWEAPON_SPAWN", function(mob)
        mob:SetMagicCastingEnabled(true)
        mob:SetAutoAttackEnabled(true)
        mob:SetMobAbilityEnabled(true)
        mob:setLocalVar("Text", dialogChoice[mob:getName()])
        mob:setLocalVar("Text_Index_1", 4)
        mob:setLocalVar("Text_Index_2", 3)
    end)

    animatedMob:addListener("ENGAGE", "AWEAPON_ENGAGE", function(mob, target)
        mob:showText(mob, mob:getLocalVar("Text"))
    end)

    animatedMob:addListener("COMBAT_TICK", "AWEAPON_CTICK", function(mob, target)
        local dialogThresholds = {90, 80, 70, 60, 50, 40, 30, 20, 10}

        for trigger, hpp in pairs(dialogThresholds) do
            if mob:getHPP() < hpp and mob:getLocalVar("dialogTrigger") < trigger then
                mob:setLocalVar("dialogTrigger", trigger)
                mob:setLocalVar("dialogQueue", mob:getLocalVar("dialogQueue") + 1)
                break
            end
        end

        if mob:getLocalVar("dialogQueue") > 0 then
            mob:showText(mob, mob:getLocalVar("Text") + mob:getLocalVar("Text_Index_1")) -- standard text
            mob:setLocalVar("dialogOne", mob:getLocalVar("Text_Index_1") + 2)
            mob:showText(mob, mob:getLocalVar("Text") + mob:getLocalVar("Text_Index_2")) -- emote
            mob:setLocalVar("dialogTwo", mob:getLocalVar("Text_Index_2") + 2)
            mob:setLocalVar("dialogQueue", mob:getLocalVar("dialogQueue") - 1)
        end

    end)

    animatedMob:addListener("MAGIC_START", "AWEAPON_MAGIC_START", function(mob, spell, action)
        if spell:getID() == 261 or spell:getID() == 73 then
            mob:setLocalVar("changeTime", os.time() + math.random(10, 15))
        end
    end)

    animatedMob:addListener("MAGIC_STATE_EXIT", "AWEAPON_MAGIC_STATE_EXIT", function(mob, spell)
        if spell:getID() == 261 or spell:getID() == 73 then
            if mob:getCurrentAction() ~= xi.action.MAGIC_INTERRUPT then
                mob:addStatusEffect(xi.effect.STUN, 1, 0, 30)
                mob:SetMagicCastingEnabled(false)
                mob:SetAutoAttackEnabled(false)
                mob:SetMobAbilityEnabled(false)
                mob:setMobMod(xi.mobMod.NO_MOVE, 1)
                mob:setMobMod(xi.mobMod.NO_DROPS, 1)
                mob:setLocalVar("warpDeath", 1)
                DespawnMob(mob:getID())
            end
        end
    end)

    animatedMob:addListener("DISENGAGE", "AWEAPON_DISENGAGE", function(mob)
        mob:showText(mob, mob:getLocalVar("Text") + 2)
    end)

    animatedMob:addListener("DEATH", "AWEAPON_DEATH", function(mob, killer)
        if mob:getLocalVar("warpDeath") ~= 1 then
            mob:showText(mob, mob:getLocalVar("Text") + 1)
        end
    end)
end

return g_mixins.families.animated_weapons
