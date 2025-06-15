--------------------------
-- Fishing
--------------------------
local fishingContest = require('scripts/globals/fishing_contest')

function onFishCommand(player)
    local zoneId = player:getZoneID()
    if fishingContest.isZoneFishingAllowed(zoneId) then
        fishingContest.startFishing(player)
    else
        player:PrintToPlayer("You can't fish here.", 0xD)
    end
end

return {
    onFishCommand = onFishCommand,
}
