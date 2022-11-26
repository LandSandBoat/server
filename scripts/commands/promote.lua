-----------------------------------
-- func: promote
-- desc: Promotes the player to a new GM level.
-----------------------------------

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
    if maxLevel < 1 then
        maxLevel = 0
    end

    -- validate target
    local targ
    if target == nil then
        error(player, "You must provide a player name.")
        return
    else
        targ = GetPlayerByName(target)
        if targ == nil then
            error(player, string.format("Player named '%s' not found!", target))
            return
        end
    end

    -- catch players trying to change level of equal or higher tiered GMs.
    if targ:getGMLevel() >= player:getGMLevel() then
        printf("%s attempting to adjust same or higher tier GM %s.", player:getName(), targ:getName())
        targ:PrintToPlayer(string.format("%s attempted to adjust your GM rank.", player:getName()))
        error(player, "You can not use this command on same or higher tiered GMs.")
        return
    end

    -- validate level
    if level == nil or level < 0 or level > maxLevel then
        error(player, string.format("Invalid level.  Must be 0 to %i.", maxLevel))
        return
    end

    -- change target gm level
    targ:setGMLevel(level)

    -- if target is being set to non-GM, remove active GM priveleges, which they will no longer be able to remove themselves
    if level == 0 then
        -- remove god mode
        if targ:getCharVar("GodMode") == 1 then
            targ:setCharVar("GodMode", 0)
            targ:delStatusEffect(xi.effect.MAX_HP_BOOST)
            targ:delStatusEffect(xi.effect.MAX_MP_BOOST)
            targ:delStatusEffect(xi.effect.MIGHTY_STRIKES)
            targ:delStatusEffect(xi.effect.HUNDRED_FISTS)
            targ:delStatusEffect(xi.effect.CHAINSPELL)
            targ:delStatusEffect(xi.effect.PERFECT_DODGE)
            targ:delStatusEffect(xi.effect.INVINCIBLE)
            targ:delStatusEffect(xi.effect.ELEMENTAL_SFORZO)
            targ:delStatusEffect(xi.effect.MANAFONT)
            targ:delStatusEffect(xi.effect.REGAIN)
            targ:delStatusEffect(xi.effect.REFRESH)
            targ:delStatusEffect(xi.effect.REGEN)
            targ:delMod(xi.mod.RACC, 2500)
            targ:delMod(xi.mod.RATT, 2500)
            targ:delMod(xi.mod.ACC, 2500)
            targ:delMod(xi.mod.ATT, 2500)
            targ:delMod(xi.mod.MATT, 2500)
            targ:delMod(xi.mod.MACC, 2500)
            targ:delMod(xi.mod.RDEF, 2500)
            targ:delMod(xi.mod.DEF, 2500)
            targ:delMod(xi.mod.MDEF, 2500)
        end

        -- remove GM flags
        local gmFlags =
        {
            GM     = 0x04000000,
            SENIOR = 0x01000000, -- Do NOT set these flags. These are here to
            LEAD   = 0x02000000, -- ensure all GM status is removed.
        }

        -- TODO: Convert this to a loop
        if targ:checkNameFlags(gmFlags.GM) then
            targ:setFlag(gmFlags.GM)
        end

        if targ:checkNameFlags(gmFlags.SENIOR) then
            targ:setFlag(gmFlags.SENIOR)
        end

        if targ:checkNameFlags(gmFlags.LEAD) then
            targ:setFlag(gmFlags.LEAD)
        end

        -- remove hidden
        if targ:getCharVar("GMHidden") == 1 then
            targ:setCharVar("GMHidden", 0)
            targ:setGMHidden(false)
        end

        -- remove costume
        targ:setCostume(0)

        -- remove wallhack
        if targ:checkNameFlags(0x00000200) then
            targ:setFlag(0x00000200)
        end
    end

    player:PrintToPlayer(string.format("%s set to tier %i.", targ:getName(), level))
    targ:PrintToPlayer(string.format("You have been set to tier %i.", level))
end
