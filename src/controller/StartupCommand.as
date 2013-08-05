package controller {
	import org.puremvc.as3.patterns.command.MacroCommand;

	public class StartupCommand extends MacroCommand {
		public function StartupCommand() {
			super();
		}
		
		override protected function initializeMacroCommand():void{
			addSubCommand(StageCommand);
		}
	}
}
