require 'rails_helper'

module RocketJobMissionControl
  RSpec.describe JobsController do
    routes { Engine.routes }

    describe "PATCH #update" do
      describe "with a valid job id" do
        let(:job) { spy(id: 42, to_param: 42) }

        before do
          allow(RocketJob::Job).to receive(:sort).and_return([])
          allow(RocketJob::Job).to receive(:find).and_return(job)
          patch :update, id: 42, job: {id: 42, priority: 12}
        end

        it "succeeds" do
          expect(response).to redirect_to(job_path(42))
        end

        it "updates the job correctly" do
          expect(job).to have_received(:update_attributes!).with('priority' => '12')
        end
      end
    end

    describe "GET #show" do
      describe "with a valid job id" do
        before do
          allow(RocketJob::Job).to receive(:sort).and_return([])
          allow(RocketJob::Job).to receive(:find).and_return('job')
          get :show, id: 42
        end

        it "succeeds" do
          expect(response.status).to be(200)
        end

        it "assigns the job" do
          expect(assigns(:job)).to be_present
        end

        it "assigns the jobs" do
          expect(assigns(:jobs)).to eq([])
        end

        it "grabs a sorted list of rocket jobs" do
          expect(RocketJob::Job).to have_received(:sort).with(created_at: :desc)
        end
      end
    end

    describe "GET #index" do
      describe "with no jobs" do
        before do
          allow(RocketJob::Job).to receive(:sort).and_return([])
          get :index
        end

        it "succeeds" do
          expect(response.status).to be(200)
        end

        it "grabs a sorted list of rocket jobs" do
          expect(RocketJob::Job).to have_received(:sort).with(created_at: :desc)
        end

        it "returns no jobs" do
          expect(assigns(:jobs)).to eq([])
        end
      end

      describe "with jobs" do
        let(:jobs) { ['fake_job1', 'fake_job2'] }

        before do
          allow(RocketJob::Job).to receive(:sort).and_return(jobs)
          get :index
        end

        it "succeeds" do
          expect(response.status).to be(200)
        end

        it "grabs a sorted list of rocket jobs" do
          expect(RocketJob::Job).to have_received(:sort).with(created_at: :desc)
        end

        it "returns the jobs" do
          expect(assigns(:jobs)).to match_array(jobs)
        end
      end
    end
  end
end
