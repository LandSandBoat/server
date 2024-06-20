-----------------------------------
-- A.M.A.N. Trove
-----------------------------------
xi.amanTrove = {}

xi.amanTrove.chestOPlentyOnTrigger = function(player, npc)
    -- Debouncing (just in case)
    if npc:getLocalVar('Triggered') == 1 then
        return
    end
    npc:setLocalVar('Triggered', 1)

    if npc:getLocalVar('Mimic') == 1 then
        xi.amanTrove.prepareMimic(player, npc)
        return
    end

    print("You have triggered the Chest O'Plenty.")


    npc:setAnimationSub(1)
    npc:setUntargetable(true)

    -- TODO: Thuds etc.
end

xi.amanTrove.terminalCofferOnTrigger = function(player, npc)
    -- Debouncing (just in case)
    if npc:getLocalVar('Triggered') == 1 then
        return
    end
    npc:setLocalVar('Triggered', 1)

    npc:setAnimationSub(1)
    npc:setUntargetable(true)

    print("You have triggered the Terminal Coffer.")

    -- TODO: Count up thuds, etc. generate loot

    -- TODO: We're going to predetermine how many thuds etc. there are
    --     : available at the start of the BC. If somehow we get to this point
    --     : and there are more than we allocated - then the player has managed
    --     : to cheat and we should report it and make sure they don't get any
    --     : loot!
end

xi.amanTrove.prepareMimic = function(player, npc)
    print("The chest is a mimic!")

    npc:setStatus(xi.status.UPDATE)
    npc:setModelId(258)
    npc:setAnimation(1) -- Combat
    npc:setAnimationSub(1) -- Mouth open

    -- Make things disappear:
    -- npc:entityAnimationPacket('kesu', npc)

    -- TODO: Make all other closed chests disappear, open chests remain.
    -- TODO: Change model into animated mimic, make name visible, set enmity, etc.
end
