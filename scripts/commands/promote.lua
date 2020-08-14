---------------------------------------------------------------------------------------------------
-- func: promote
-- desc: Promotes the player to a new GM level.
---------------------------------------------------------------------------------------------------

cmdprops =
{
    permission = 1,
    parameters = "si"
}

function error(player, msg)
    player:PrintToPlayer(msg)
    player:PrintToPlayer("!promote <player> <level>")
end

function onTrigger(player, target, level)
    -- determine maximum level player can promote to
    local maxLevel = player:getGMLevel() - 1
    if (maxLevel < 1) then
        maxLevel = 0
    end

    -- validate target
    local targ
    if (target == nil) then
        error(player, "You must provide a player name.")
        return
    else
        targ = GetPlayerByName(target)
        if (targ == nil) then
            error(player, string.format( "Player named '%s' not found!", target ) )
            return
        end
    end

    -- catch players trying to change level of equal or higher tiered GMs.
    if (targ:getGMLevel() >= player:getGMLevel()) then
        printf( "%s attempting to adjust same or higher tier GM %s.", player:getName(), targ:getName() )
        targ:PrintToPlayer(string.format( "%s attempted to adjust your GM rank.", player:getName() ))
        error(player, "You can not use this command on same or higher tiered GMs.")
        return
    end

    -- validate level
    if (level == nil or level < 0 or level > maxLevel) then
        error(player, string.format("Invalid level.  Must be 0 to %i.", maxLevel ))
        return
    end

    -- change target gm level
    targ:setGMLevel(level)

    -- if target is being set to non-GM, remove active GM priveleges, which they will no longer be able to remove themselves
    if level == 0 then
        -- remove god mode
        if targ:getCharVar("GodMode") == 1 then
            targ:setCharVar("GodMode", 0)
            targ:delStatusEffect(tpz.effect.MAX_HP_BOOST)
            targ:delStatusEffect(tpz.effect.MAX_MP_BOOST)
            targ:delStatusEffect(tpz.effect.MIGHTY_STRIKES)
            targ:delStatusEffect(tpz.effect.HUNDRED_FISTS)
            targ:delStatusEffect(tpz.effect.CHAINSPELL)
            targ:delStatusEffect(tpz.effect.PERFECT_DODGE)
            targ:delStatusEffect(tpz.effect.INVINCIBLE)
            targ:delStatusEffect(tpz.effect.ELEMENTAL_SFORZO)
            targ:delStatusEffect(tpz.effect.MANAFONT)
            targ:delStatusEffect(tpz.effect.REGAIN)
            targ:delStatusEffect(tpz.effect.REFRESH)
            targ:delStatusEffect(tpz.effect.REGEN)
            targ:delMod(tpz.mod.RACC, 2500)
            targ:delMod(tpz.mod.RATT, 2500)
            targ:delMod(tpz.mod.ACC, 2500)
            targ:delMod(tpz.mod.ATT, 2500)
            targ:delMod(tpz.mod.MATT, 2500)
            targ:delMod(tpz.mod.MACC, 2500)
            targ:delMod(tpz.mod.RDEF, 2500)
            targ:delMod(tpz.mod.DEF, 2500)
            targ:delMod(tpz.mod.MDEF, 2500)
        end

        -- remove GM flags
        local FLAG_GM               = 0x04000000
        local FLAG_SENIOR           = 0x01000000 -- Do NOT set these flags. These are here to
        local FLAG_LEAD             = 0x02000000 -- ensure all GM status is removed.

        if targ:checkNameFlags(FLAG_GM) then
            targ:setFlag(FLAG_GM)
        end
        if targ:checkNameFlags(FLAG_SENIOR) then
            targ:setFlag(FLAG_SENIOR)
        end
        if targ:checkNameFlags(FLAG_LEAD) then
            targ:setFlag(FLAG_LEAD)
        end

        -- remove hidden
        if targ:getCharVar("GMHidden") == 1 then
            targ:setCharVar("GMHidden", 0)
            targ:setGMHidden(false)
        end

        -- remove costume
        targ:costume(0)

        -- remove wallhack
        if targ:checkNameFlags(0x00000200) then
            targ:setFlag(0x00000200)
        end
    end

    player:PrintToPlayer(string.format( "%s set to tier %i.", targ:getName(), level ))
    targ:PrintToPlayer(string.format( "You have been set to tier %i.", level ))
end
