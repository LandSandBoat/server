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
    ["DE_A.Knuckles"] = ID.text.ANIMATED_KNUCKLES_DIALOG,
    ["DE_A.Dagger"] = ID.text.ANIMATED_DAGGER_DIALOG,
    ["DE_A.Longsword"] = ID.text.ANIMATED_LONGSWORD_DIALOG,
    ["DE_A.Claymore"] = ID.text.ANIMATED_CLAYMORE_DIALOG,
    ["DE_A.Tabar"] = ID.text.ANIMATED_TABAR_DIALOG,
    ["DE_A.Great Axe"] = ID.text.ANIMATED_GREATAXE_DIALOG,
    ["DE_A.Spear"] = ID.text.ANIMATED_SPEAR_DIALOG,
    ["DE_A.Scythe"] = ID.text.ANIMATED_SCYTHE_DIALOG,
    ["DE_A.Kunai"] = ID.text.ANIMATED_KUNAI_DIALOG,
    ["DE_A.Tachi"] = ID.text.ANIMATED_TACHI_DIALOG,
    ["DE_A.Hammer"] = ID.text.ANIMATED_HAMMER_DIALOG,
    ["DE_A.Staff"] = ID.text.ANIMATED_STAFF_DIALOG,
    ["DE_A.Longbow"] = ID.text.ANIMATED_LONGBOW_DIALOG,
    ["DE_A.Gun"] = ID.text.ANIMATED_GUN_DIALOG,
    ["DE_A.Horn"] = ID.text.ANIMATED_HORN_DIALOG,
    ["DE_A.Shield"] = ID.text.ANIMATED_SHIELD_DIALOG,
}

local animatedFragments =
{
    ["DE_A.Claymore"]  = xi.items.INTRICATE_FRAGMENT,
    ["DE_A.Dagger"]    = xi.items.ORNATE_FRAGMENT,
    ["DE_A.Great Axe"] = xi.items.SERAPHIC_FRAGMENT,
    ["DE_A.Gun"]       = xi.items.ETHEREAL_FRAGMENT,
    ["DE_A.Hammer"]    = xi.items.HEAVENLY_FRAGMENT,
    ["DE_A.Horn"]      = xi.items.MYSTERIAL_FRAGMENT,
    ["DE_A.Knuckles"]  = xi.items.MYSTIC_FRAGMENT,
    ["DE_A.Kunai"]     = xi.items.DEMONIAC_FRAGMENT,
    ["DE_A.Longbow"]   = xi.items.SNARLED_FRAGMENT,
    ["DE_A.Longsword"] = xi.items.HOLY_FRAGMENT,
    ["DE_A.Scythe"]    = xi.items.TENEBROUS_FRAGMENT,
    ["DE_A.Shield"]    = xi.items.SUPERNAL_FRAGMENT,
    ["DE_A.Spear"]     = xi.items.STELLAR_FRAGMENT,
    ["DE_A.Staff"]     = xi.items.CELESTIAL_FRAGMENT,
    ["DE_A.Tabar"]     = xi.items.RUNAEIC_FRAGMENT,
    ["DE_A.Tachi"]     = xi.items.DIVINE_FRAGMENT
}

g_mixins.families.animated_weapons = function(animatedMob)
    animatedMob:addListener("SPAWN", "AWEAPON_SPAWN", function(mob)
        mob:setMagicCastingEnabled(true)
        mob:setAutoAttackEnabled(true)
        mob:setMobAbilityEnabled(true)
        mob:setLocalVar("Text", dialogChoice[mob:getName()])
        mob:setLocalVar("Text_Index_1", 4)
        mob:setLocalVar("Text_Index_2", 3)
    end)

    animatedMob:addListener("ENGAGE", "AWEAPON_ENGAGE", function(mob, target)
        mob:showText(mob, mob:getLocalVar("Text"))
    end)

    animatedMob:addListener("COMBAT_TICK", "AWEAPON_CTICK", function(mob, target)
        local dialogThresholds = { 90, 80, 70, 60, 50, 40, 30, 20, 10 }

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
                mob:setMagicCastingEnabled(false)
                mob:setAutoAttackEnabled(false)
                mob:setMobAbilityEnabled(false)
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

    animatedMob:addListener("ITEM_DROPS", "ITEM_DROPS_ANIMATED", function(mob, loot)
        for k, v in pairs(animatedFragments) do
            if mob:getName() == k then
                loot:addItem(v, xi.loot.rate.GUARANTEED)
            end
        end
    end)
end

return g_mixins.families.animated_weapons
