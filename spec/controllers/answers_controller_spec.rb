# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user:) }
  let!(:answer) { create(:answer, question:, user:) }

  describe 'POST #create' do
    before { login(user) }

    context 'with valid attributes' do
      subject { post :create, params: { question_id: question, answer: attributes_for(:answer) } }

      it 'saves an answer to DB' do
        expect { subject }.to change(Answer, :count).by(1)
      end

      it 'has 200 response' do
        expect(response).to have_http_status(:success)
      end
    end

    context 'with invalid attributes' do
      subject { post :create, params: { question_id: question, answer: attributes_for(:answer, :invalid) } }

      it 'doesn\'t save a answer to DB' do
        expect { subject }.to_not change(Answer, :count)
      end

      it 'renders current question view' do
        subject
        expect(response).to render_template 'questions/show'
      end
    end
  end

  describe 'PATCH #update' do
    before { login(user) }

    context 'with valid attributes' do
      it 'assigns the requested answer to @answer' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }
        expect(assigns(:answer)).to eq answer
      end

      it 'changes answer attributes' do
        patch :update, params: { id: answer, answer: { body: 'changed title' } }
        answer.reload

        expect(answer.body).to eq 'changed title'
      end

      it 'redirects to updated answer view' do
        patch :update, params: { id: answer, answer: attributes_for(:answer) }
        expect(response).to redirect_to answer.question
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: answer, answer: attributes_for(:answer, :invalid) } }

      it 'doesn\'t change the answer' do
        answer.reload

        expect(answer.body).to eq 'MyText'
      end

      it 're-renders edit answer view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user) }

    it 'deletes the answer' do
      expect { delete :destroy, params: { id: answer } }.to change(Answer, :count).by(-1)
    end
    it 'redirects to question' do
      delete :destroy, params: { id: answer }
      expect(response).to redirect_to question_path(answer.question)
    end
  end
end
