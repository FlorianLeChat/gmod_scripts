local function SetArmor(ply, cmd, args)

	if not FAdmin.Access.PlayerHasPrivilege(ply, "SetArmor") then

		FAdmin.Messages.SendMessage(ply, 5, "No access!")

		return false

	end

	local playerID = args[1]

	if not playerID then

		FAdmin.Messages.SendMessage(ply, 5, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), "(PlayerID)"))

		return false

	end

	local value = tonumber(args[2]) or 100
	local targets = FAdmin.FindPlayer(args[1]) or {}

	if #targets == 0 then

		FAdmin.Messages.SendMessage(ply, 5, DarkRP.getPhrase("invalid_x", DarkRP.getPhrase("arguments"), "(Targets)"))

		return false

	end

	for i = 1, #targets do

		local target = targets[i]

		if FAdmin.Access.PlayerHasPrivilege(ply, "SetArmor", target) then

			target:SetArmor(value)

		end

	end

	FAdmin.Messages.FireNotification("setarmor", ply, targets, {value})

	return true, targets, value

end

FAdmin.StartHooks["SetArmor"] = function()

	FAdmin.Messages.RegisterNotification({

		name = "setarmor",
		hasTarget = true,
		receivers = "everyone",
		writeExtraInfo = function(info) net.WriteString(info[1]) end,
		message = {"instigator", " set the armor of ", "targets", " to ", "extraInfo.1"}

	})

	FAdmin.Access.AddPrivilege("SetArmor", 2)

	FAdmin.Commands.AddCommand("armor", SetArmor)
	FAdmin.Commands.AddCommand("setarmor", SetArmor)

end