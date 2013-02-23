bank 						= {}
bank.Config 				= {}

bank.Config.StartingCash 			= 	5000 	--	Cash to get when you buy a bank account
bank.Config.DropCash				=	true	--	Drop cash on death
bank.Config.DropAmt					=	0.9		--	Percentage of cash to drop on death (Out of 1)

bank.Config.Bronze = {}
bank.Config.Bronze.MaxStore 		= 	5000 	--	How much they can store in their bank at one time (0 = unlimited)
bank.Config.Bronze.Interest 		= 	0.05	--	The interest they recieve every payday
bank.Config.Bronze.Protected 		=	0.7		--	Percentage (Out of 1) How much is protected in a robbery

bank.Config.Silver = {}
bank.Config.Silver.MaxStore 		= 	30000 	--	How much they can store in their bank at one time (0 = unlimited)
bank.Config.Silver.Interest 		= 	0.07	--	The interest they recieve every payday
bank.Config.Silver.Protected 		=	0.8		--	Percentage (Out of 1) How much is protected in a robbery

bank.Config.Gold = {}
bank.Config.Gold.MaxStore 			= 	0 		--	How much they can store in their bank at one time (0 = unlimited)
bank.Config.Gold.Interest 			= 	0.08	--	The interest they recieve every payday
bank.Config.Gold.Protected 			=	0.9		--	Percentage (Out of 1) How much is protected in a robbery

bank.Config.UseMySQL 				= 	false	-- 	Leave this as false unless you know what your doing (Configure the database in sv_db.lua)




--Config below this line is currently obsolete until later versions

bank.Config.StockIDs				= 	{"GOOG","YHOO","^ftse","^ftmc","AIM","NSX.L","^FTAI","^FTAS","BRNS.L","PLE.L"}
												-- 	These symbols can be found in the URL on the yahoo stock market

bank.Config.AllowRobbery			=	true	--	Enabling this allows the bank to be robbed
bank.Config.PercRobbable			=	0.4		--	Percentage (Out Of 1). How much money is available to robbery (Per Player Protect Is Added On After This)
bank.Config.AllowedJobs				= {TEAM_GANG, TEAM_MOB}
												--	Seperate jobs with a comma, these are teams which are allowed to actually retrieve the money

bank.Config.WarnFirst				=	true	--	Warns the player and removes them from vault, on their second try they are kicked
bank.Config.BanNonAllowed			=	true	--	Bans all players whom enter the vault who are not of the allowed jobs or cops
bank.Config.BanTime					=	10		--	Ban length in minutes
bank.Config.BanMessage				=	"Do Not Enter The Vault If You Are Not A Gangster"
												--	Message to display when they are kicked/banned


