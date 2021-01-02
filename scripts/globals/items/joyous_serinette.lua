-----------------------------------------
-- ID: 5425
-- Item: Joyous Serinette
-- Item Effect: Change Music
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local alliance = target:getAlliance()
    for i, member in alliance:pairs() do
        if member:getZoneID() == target:getZoneID() then
            member:ChangeMusic(0, 214) -- Eternal Oath
            member:ChangeMusic(1, 214) -- Eternal Oath
        end
    end
end
