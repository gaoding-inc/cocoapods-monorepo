require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Monorepo do
    describe 'CLAide' do
      it 'registers it self' do
        Command.parse(%w{ monorepo }).should.be.instance_of Command::Monorepo
      end
    end
  end
end

