from flask import Blueprint, request, jsonify, session
from app.services.openai_service import chat_service
from app.models.message import Conversation

chat_bp = Blueprint('chat', __name__)

# In-memory storage for conversations
conversations = {}

@chat_bp.route('/chat', methods=['POST'])
def chat():
    data = request.get_json()
    user_message = data.get('message', '').strip()
    temperature = float(data.get('temperature', 0.7))
    if not user_message:
        return jsonify({'response': 'Please enter a message.'}), 400

    # Build the conversation (system + user message)
    system_msg = chat_service.create_system_message()
    messages = [system_msg, {"role": "user", "content": user_message}]
    try:
        response = chat_service.get_chat_response(messages, temperature=temperature)
        return jsonify({'response': response})
    except Exception as e:
        return jsonify({'response': 'Error: Unable to get response.'}), 500

@chat_bp.route('/chat/delete/<session_id>', methods=['DELETE'])
def delete_conversation(session_id: str):
    """Delete a conversation completely"""
    if session_id in conversations:
        del conversations[session_id]
        return jsonify({'status': 'deleted'})
    return jsonify({'error': 'Conversation not found'}), 404